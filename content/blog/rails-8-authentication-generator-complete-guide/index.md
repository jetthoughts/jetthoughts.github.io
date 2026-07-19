---
title: "Rails 8 Authentication Generator: Complete Guide"
description: "Replace Devise with Rails 8's built-in authentication. Sessions table, password reset, email verification, rate limiting, and production hardening. Working code."
date: 2026-07-29
draft: false
tags: ["rails", "rails-8", "authentication", "devise", "security", "tutorial"]
canonical_url: "https://jetthoughts.com/blog/rails-8-authentication-generator-complete-guide/"
slug: "rails-8-authentication-generator-complete-guide"
cover_image: "cover.png"
metatags:
  image: cover.png
cover_image_alt: "Dark technical cover for Rails 8 Authentication Generator. JetThoughts TUTORIAL brand mark, Ruby on Rails 2026 pill, low-poly ruby gem, stat chips for sessions/resets/rate-limits, PRODUCTION READY status indicator."
---

Every Rails app you've built in the last decade started with `gem "devise"`. The generator spits out 18 files. You delete the ones you don't need, override the ones you do, and spend the next three years hoping the monkey-patches in `config/initializers/devise.rb` survive the next major version bump.

Rails 8 ships a built-in authentication generator that replaces most of what Devise does with code you own. One command. Zero gems. Full control.

## TL;DR

Rails 8's `bin/rails generate authentication` creates a complete auth system: `User` and `Session` models, session controllers, password reset flow, email verification, and a `current_user` helper. The code lives in your app - no engine, no initializer, no monkey-patching. Use it when you want full control over authentication. Keep Devise when you need omniauth, account locking, or trackable out of the box.

**Quick start**: `rails new myapp && cd myapp && bin/rails generate authentication` → migrate → start your server. The login, signup, and password reset flows all work. Customize them by editing controllers you actually own.

## What the generator gives you

Run `bin/rails generate authentication` in a fresh Rails 8 app and it creates:

| File | Purpose |
|---|---|
| `app/models/user.rb` | `has_secure_password` model with validations |
| `app/models/session.rb` | Database-backed sessions (not cookie-only) |
| `app/models/current.rb` | Thread-safe `Current` attributes for the request cycle |
| `app/controllers/sessions_controller.rb` | Login and logout |
| `app/controllers/passwords_controller.rb` | Forgot password + reset flow |
| `app/controllers/registrations_controller.rb` | Signup (if generated) |
| `app/controllers/confirmations_controller.rb` | Email verification |
| `app/controllers/application_controller.rb` | Updated with `include Authentication` |
| `app/controllers/concerns/authentication.rb` | `authenticate!`, `current_user`, `user_signed_in?` helpers |
| `app/mailers/passwords_mailer.rb` | Password reset emails |
| `app/views/sessions/` | Login form, partials |
| `app/views/passwords/` | Forgot password, reset, edit views |
| `db/migrate/*_create_users.rb` | `users` table with `password_digest` |
| `db/migrate/*_create_sessions.rb` | `sessions` table tied to `users` |

Here's what Devise generates for comparison: 18 files including an engine, an initializer with 200+ config options, and a router DSL you don't control. The Rails 8 generator writes less code that does less - and that's the point. Every line lives in your app where you can read it and change it without fighting an engine.

```ruby
# app/models/user.rb - what the generator produces
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:password_digest] }
end
```

The password validation only fires when the password digest changes - not on every save. If you add a `bio` column later and call `user.update(bio: "...")`, it won't reject the update because the password hasn't changed. Devise requires you to configure this separately; the generator gets it right by default.

## `has_secure_password` - what it does and doesn't do

`has_secure_password` adds three things to your model:

1. **Password hashing via bcrypt.** The `password_digest` column stores a bcrypt hash. The plaintext password never touches the database.
2. **Virtual `password` and `password_confirmation` attributes.** They exist on the model instance but aren't persisted - only the digest is.
3. **An `authenticate` method.** Call `user.authenticate("mypassword")` and it returns `self` on match, `false` on mismatch.

```ruby
# The bcrypt check behind user.authenticate(password)
user = User.find_by(email_address: "founder@example.com")
if user.authenticate(params[:password])
  # password matched - create a session
else
  # password didn't match - redirect with error
end
```

What it doesn't do: rate limiting, password complexity rules, account locking, password history, or multi-factor auth. Each of those is a decision you make for your app, not a default you inherit from a gem. We'll cover the ones that matter for production below.

## `authenticate_by` - the safer lookup

Rails 7.1 shipped `authenticate_by` as a class method. The generator uses it everywhere. The difference from `find_by` + `authenticate` matters:

```ruby
# What you'd write without authenticate_by - two queries and a timing leak
user = User.find_by(email_address: params[:email])
if user&.authenticate(params[:password])
  # ...
end

# authenticate_by - one query, constant-time comparison
if (user = User.authenticate_by(email_address: params[:email], password: params[:password]))
  start_new_session_for user
  redirect_to after_authentication_url
else
  render :new, alert: "Invalid email or password."
end
```

`authenticate_by` runs the lookup and the bcrypt comparison in one step. It uses a constant-time comparison to prevent timing attacks on the password - someone can't measure response latency to figure out whether an email exists in the database. It returns the user on success and `nil` on failure with the same timing profile either way.

If you're still writing `find_by` + `authenticate` in custom controllers, switch to `authenticate_by`. The generator already does.

## Sessions: database-backed, not cookie-only

The biggest architectural decision the generator makes is storing sessions in a database table instead of just a signed cookie.

```ruby
# app/models/session.rb
class Session < ApplicationRecord
  belongs_to :user
  before_create { self.user_agent = Current.user_agent }
  before_create { self.ip_address = Current.ip_address }
end

# db/migrate/*_create_sessions.rb
create_table :sessions do |t|
  t.references :user, null: false, foreign_key: true
  t.string :ip_address
  t.string :user_agent
  t.timestamps
end
```

The cookie-only approach stores a signed user ID in the browser. It works. Until you need to log someone out of all their devices and realize you can't - the cookie is valid until it expires, period. The user changed their password after a breach? Every device with the old cookie is still logged in.

Database-backed sessions fix this. Each login creates a `Session` row. The cookie stores a session token, not a user ID. To log out everywhere, you delete the rows:

```ruby
# Log out from all devices
Current.user.sessions.destroy_all
```

That's it. Every device's cookie becomes invalid on the next request because the server-side session no longer exists.

The session cookie itself is configured in the generator:

```ruby
# app/controllers/concerns/authentication.rb
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_request_details
    before_action :authenticate!
  end

  private

  def authenticate!
    if (session_record = Session.find_by(id: cookies.signed[:session_token]))
      Current.session = session_record
    else
      redirect_to new_session_path, alert: "Please sign in."
    end
  end

  def start_new_session_for(user)
    session = user.sessions.create!
    cookies.signed.permanent[:session_token] = { value: session.id, httponly: true, secure: Rails.env.production? }
  end

  def terminate_session
    Current.session.destroy
    cookies.delete(:session_token)
  end
end
```

The `httponly` flag prevents JavaScript from reading the cookie - XSS can't steal the session token. The `secure` flag ensures the cookie only travels over HTTPS in production. The `signed` cookie prevents tampering. None of this requires configuration because it's spelled out in code you can read.

## Password reset - the flow that trips up every hand-rolled auth

The generator includes a complete forgot-password flow. The pattern it uses is the same one every production app eventually converges on:

```ruby
# app/controllers/passwords_controller.rb - abridged
class PasswordsController < ApplicationController
  allow_unauthenticated_access

  def new
    # Show the "forgot password?" form
  end

  def create
    if (user = User.find_by(email_address: params[:email_address]))
      PasswordsMailer.reset(user).deliver_later
    end
    # Always redirect with the same message - don't leak whether the email exists
    redirect_to new_session_path, notice: "Check your email for reset instructions."
  end

  def edit
    # Validate the reset token from the email link
    @user = User.find_by_token_for!(:password_reset, params[:token])
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_session_path, alert: "Reset link is invalid or has expired."
  end

  def update
    @user = User.find_by_token_for!(:password_reset, params[:token])
    if @user.update(password_params)
      redirect_to new_session_path, notice: "Password reset. Sign in."
    else
      render :edit, status: :unprocessable_entity
    end
  end
end
```

Three details that matter:

**1. Don't leak email existence in the `create` action.** The generator redirects with the same message whether the email exists or not. If you say "email not found," an attacker can enumerate your user base. If you say "check your email" for both cases, they can't. The timings differ slightly - the email delivery path takes longer - so the generator always calls `redirect_to` outside the conditional.

**2. The reset token expires.** The generator uses `generates_token_for` with an expiry window. The token embedded in the email link is only valid for a limited window (default 15 minutes). After that, `find_by_token_for!` raises `InvalidSignature` and the user starts over.

**3. The token self-invalidates on password change.** The `generates_token_for` API signs the token against `password_salt`. When the user changes their password, bcrypt generates a new salt, and the old token becomes invalid automatically. Someone who intercepted the reset email can't reuse the same link after the password has been changed.

## Email verification - confirm before allowing access

The generator's confirmation flow ensures the email address belongs to the person who signed up:

```ruby
# app/models/user.rb - additions for email verification
class User < ApplicationRecord
  has_secure_password

  generates_token_for :email_confirmation, expires_in: 24.hours do
    email_address
  end

  before_create :generate_confirmation_token
end

# app/controllers/confirmations_controller.rb
class ConfirmationsController < ApplicationController
  allow_unauthenticated_access

  def new
    # Show "check your email" page
  end

  def create
    @user = User.find_by_token_for!(:email_confirmation, params[:token])
    @user.confirm!
    start_new_session_for @user
    redirect_to root_path, notice: "Email confirmed."
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_session_path, alert: "Confirmation link is invalid or has expired."
  end
end
```

The `generates_token_for` API is worth understanding because it replaces a lot of hand-rolled token logic. It produces a signed, time-limited token tied to a specific attribute. If the email address changes, the old token becomes invalid - even if it hasn't expired. This prevents someone from signing up with `attacker@evil.com`, changing their email to `victim@company.com`, and confirming the attacker's original email to get access.

```ruby
# generates_token_for is worth understanding:
user = User.find_by(email_address: "new@example.com")
token = user.generate_token_for(:email_confirmation)
# token is valid for 24 hours, tied to this user's email_address

user.update(email_address: "changed@example.com")
# The old token is now invalid - even if it hasn't expired.
# Changing the email changes what the token signs.
```

## Rate limiting - the generator doesn't do this, so here's what to add

The generator ships without rate limiting. A determined attacker can hammer `/passwords` or `/sessions` with a script, enumerating users or brute-forcing passwords. The fix is minimal:

```ruby
# config/initializers/rack_attack.rb
class Rack::Attack
  # Throttle login attempts by IP - 5 per 20 seconds
  throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == "/sessions" && req.post?
  end

  # Throttle password reset requests by IP - 3 per hour
  throttle("passwords/ip", limit: 3, period: 1.hour) do |req|
    req.ip if req.path == "/passwords" && req.post?
  end

  # Throttle signups by IP - 3 per hour
  throttle("signups/ip", limit: 3, period: 1.hour) do |req|
    req.ip if req.path == "/registrations" && req.post?
  end

  # Blocklist after repeated violations
  Rack::Attack.blocklist("repeat offenders") do |req|
    Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 10, findtime: 10.minutes, bantime: 1.hour) do
      req.path.match?(/^\/(sessions|passwords|registrations)/) && req.post?
    end
  end
end
```

Add `gem "rack-attack"` to your Gemfile, add this initializer, and your auth endpoints are protected. The blocklist fires after 10 violations in 10 minutes from the same IP - a one-hour ban. Adjust the thresholds for your traffic patterns.

## When to keep Devise

The Rails 8 auth generator handles 80% of what Devise does. The 20% where Devise still wins:

**OmniAuth integration.** The generator has no built-in OAuth. Adding Google, GitHub, or Apple sign-in requires wiring up the omniauth gem and callback controller yourself. Devise gives you `devise :omniauthable` with a one-line config per provider. If your app relies on social login, Devise saves you a day of integration work.

**Account locking.** Brute-force protection beyond rate limiting - locking an account after N failed attempts, requiring admin or email-based unlock - is built into Devise via `devise :lockable`. The generator delegates this to `rack-attack`, which is IP-based, not account-based. An attacker with a botnet can rotate IPs and keep trying passwords against the same account despite rate limiting. If your threat model includes targeted credential attacks, Devise's account-level locking is the right primitive.

**Trackable and timeoutable.** Devise ships with `trackable` (sign-in count, timestamps, IP address) and `timeoutable` (auto-logout after inactivity). The generator provides neither out of the box. You can add them - the `sessions` table already has `ip_address` and timestamps - but it's code you write instead of a config flag you set.

**Enterprise features.** LDAP, SAML, two-factor via TOTP, password history enforcement, password complexity rules - Devise has gems for all of these. The generator is a starting point. If you need three enterprise auth features on day one, starting from the generator means building all three from scratch.

If you're migrating from Devise, see [our Devise to Rails 8 auth migration guide](/blog/rails-8-authentication-generator-devise-migration/). If you're starting a new app and none of the Devise-only features above are requirements, use the generator. You can always add Devise later - removing it is harder than adding it.

## Production hardening checklist

Before deploying the generated auth to production:

- [ ] **Enable `config.force_ssl = true`** in `config/environments/production.rb`. Session cookies marked `secure: true` (as the generator does) will be rejected by browsers over plain HTTP. Force SSL prevents misconfigurations from becoming security gaps.
- [ ] **Install and configure `rack-attack`** with the throttle rules above. The generator has no built-in rate limiting.
- [ ] **Configure ActionMailer** with a production email service (Postmark, SendGrid). Password reset and email confirmation emails need to actually arrive. Test this in staging before going live.
- [ ] **Set `Rails.application.config.session_store :cookie_store, expire_after: 2.weeks`**. The generator's session cookie is permanent by default. A 2-week idle timeout is a reasonable default - users who disappear for a month shouldn't stay logged in.
- [ ] **Audit `config/credentials.yml.enc`** for the `secret_key_base`. The signed cookies in `cookies.signed[:session_token]` depend on it. Rotating `secret_key_base` invalidates all sessions.
- [ ] **Add a `before_action :refresh_session`** to `ApplicationController` that bumps the session cookie's expiry on each authenticated request. Without this, a user who logs in, works for 30 minutes, and walks away will be logged out at exactly `expire_after` from their initial login - not from their last activity.
- [ ] **Set `SameSite=Strict`** on the session cookie if your app doesn't need cross-site requests. The generator uses Rails defaults. Add `same_site: :strict` to the `cookies.signed.permanent` line in `start_new_session_for` if your login form is on the same origin as your app.

## What we shipped with the generator

A client came to us in Q1 2026 with a Rails app running Devise. They had three custom modules: an email verification that didn't verify, a password reset that was broken in production (ActionMailer misconfiguration), and a session timeout that had been commented out in 2024 because it kept logging out mobile users.

None of these were Devise's fault. Devise was doing exactly what the original developers had configured it to do three years ago. The problem was that nobody on the current team understood all 200 lines of `config/initializers/devise.rb`. The developer who wrote it had left. The remaining team was afraid to touch it.

We migrated them to the generator in two days. The password reset started working because the code was explicit - `PasswordsMailer.reset(user).deliver_later` with a visible `ActionMailer` configuration, not a Devise module that dispatched emails through an invisible pipeline. The session timeout was four lines in `Authentication#authenticate!` that anyone on the team could read and adjust. The email verification worked because `generates_token_for :email_confirmation` is self-documenting.

The takeaway isn't that Devise is bad. It's that authentication code you can't read is a liability. The Rails 8 generator gives you authentication code you can read - and therefore fix - without opening a gem's source.

## The decision in 60 seconds

Use the Rails 8 authentication generator when you want to own your auth code, when your needs are standard (email/password, password reset, email verification), and when your team values simplicity over feature completeness.

Keep Devise when you need omniauth, account locking, or enterprise features on day one. Devise is battle-tested. The generator is newer. Both are valid choices. The question is whether the features you're not using are worth the lines of code you can't touch.

For most new Rails 8 apps, the answer is no.

*For the full migration guide from Devise, see [Devise to Rails 8 Auth: Migration Guide](/blog/rails-8-authentication-generator-devise-migration/). For deployment patterns, see [Rails 8 Docker Production Deployment](/blog/rails-8-docker-deployment-production-guide/) and our [Solid Queue migration guide](/blog/rails-8-solid-queue-migration-guide/). For performance tuning on the same stack, see [Falcon in Production: Benchmarks, Memory & Worker Count](/blog/falcon-web-server-production-tuning-benchmarks/). If you're weighing a Devise migration on a real codebase, [our Rails team can help](/services/app-web-development/).*
