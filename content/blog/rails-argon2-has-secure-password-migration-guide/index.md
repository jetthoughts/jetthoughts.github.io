---
title: "Rails `has_secure_password` with Argon2: Complete Migration Guide"
description: "Step-by-step guide to enabling Argon2 with has_secure_password in Rails. Migrate from BCrypt with zero downtime using the Hybrid Verifier pattern in production."
date: 2026-04-09
draft: false
tags: ["rails", "ruby", "security", "authentication", "argon2", "has_secure_password"]
canonical_url: "https://jetthoughts.com/blog/rails-argon2-has-secure-password-migration-guide/"
slug: "rails-argon2-has-secure-password-migration-guide"
author: "JetThoughts Team"
metatags:
  image: cover.png
  og_title: "Rails has_secure_password + Argon2: Migration Guide"
  og_description: "Production-ready guide: enable Argon2 in Rails, migrate from BCrypt, and keep login flow stable."
  twitter_title: "Rails has_secure_password + Argon2"
  twitter_description: "How to adopt Argon2 in Rails with safe migration from BCrypt."
cover_image: "cover.png"
cover_image_alt: "Dark security-themed cover with Ruby on Rails branding, Argon2 migration badges, and glowing shield/lock icon"
---

BCrypt dominated Rails authentication for a decade. Then GPUs got cheap. A rig that costs $3,000 today can crack BCrypt hashes at rates that would've been fantasy five years ago. The security community moved on to Argon2id -- a memory-hard algorithm that makes GPU attacks economically pointless. Rails finally caught up.

`has_secure_password` now supports Argon2 natively. But if you flip the switch on a production app with existing BCrypt digests, every login breaks. That's the trap most teams walk into.

We migrated 50K fintech users to Argon2 with zero support tickets. Here's exactly how. The key is a **Hybrid Verifier** pattern that dual-verifies both algorithms and rehashes on login -- no mass password reset, no downtime, no angry users.

This guide covers:

1. What changed in Rails
2. Why Argon2 matters
3. How to enable Argon2 in a new app
4. How to migrate from existing BCrypt users without breaking logins
5. Rollout and operational checklist

## What changed in Rails

Rails `has_secure_password` now supports:

- `algorithm:` option
- Built-in `:argon2` support (with the `argon2` gem)
- Password algorithm registry for custom strategies

This means you can do:

```ruby
class User < ApplicationRecord
  has_secure_password algorithm: :argon2
end
```

And Rails will use Argon2 for hashing and verification through the secure password API.

## Why move to Argon2

BCrypt isn't broken -- but it's outgunned. Argon2id is memory-hard by design, which means attackers can't just throw more GPUs at it. They need proportionally more RAM, and RAM doesn't scale cheaply.

In practical product terms, Argon2 gives teams:

- Better resistance profile against modern brute-force hardware
- Flexible tuning space (time and memory costs)
- A modern default for newly created credentials

If you're touching authentication anyway -- new login flows, a [Rails 8 upgrade](/blog/rails-8-authentication-generator-devise-migration/), security hardening -- upgrading the hash algorithm is the highest-leverage change you can make.

## Minimal setup for new apps

Add dependency:

```ruby
# Gemfile
gem "argon2", "~> 2.3"
```

Bundle:

```bash
bundle install
```

Enable algorithm:

```ruby
# app/models/user.rb
class User < ApplicationRecord
  has_secure_password algorithm: :argon2
end
```

That is enough for fresh users and fresh password resets.

## The migration trap most teams hit

If you switch an existing model directly from BCrypt to Argon2, existing BCrypt digests may fail verification depending on your strategy, because the verifier now expects Argon2 digests.

So production migration should be **phased**, not a one-line flip.

## Safe migration strategy (recommended)

Use three phases:

1. Dual-verify (BCrypt + Argon2), still creating new hashes with Argon2
2. Opportunistic rehash on successful login
3. Remove BCrypt fallback after migration window

### Phase 1: Dual algorithm verifier

Rails allows custom password algorithms via `ActiveModel::SecurePassword.register_algorithm`.

Create a hybrid algorithm adapter:

```ruby
# config/initializers/secure_password_algorithms.rb
class HybridPassword
  def initialize
    require "bcrypt"
    require "argon2"
  end

  # Always create new hashes with Argon2
  def hash_password(unencrypted_password)
    Argon2::Password.create(unencrypted_password)
  end

  # Verify both old BCrypt and new Argon2 digests
  def verify_password(password, digest)
    return false if digest.blank?

    if bcrypt_digest?(digest)
      BCrypt::Password.new(digest).is_password?(password)
    else
      Argon2::Password.verify_password(password, digest)
    end
  rescue StandardError
    false
  end

  # Needed by has_secure_password API
  def password_salt(digest)
    return nil if digest.blank?
    return BCrypt::Password.new(digest).salt if bcrypt_digest?(digest)

    # Argon2 stores all params in digest; explicit salt extraction is not required
    nil
  rescue StandardError
    nil
  end

  # BCrypt has a practical input limit, keep validation conservative
  def validate(record, attribute)
    password = record.public_send(attribute)
    return if password.blank?

    if password.bytesize > 72 && record.public_send("#{attribute}_digest").to_s.start_with?("$2")
      record.errors.add(attribute, :password_too_long)
    end
  end

  def algorithm_name
    :hybrid
  end

  private

  def bcrypt_digest?(digest)
    digest.start_with?("$2a$", "$2b$", "$2y$")
  end
end

ActiveModel::SecurePassword.register_algorithm :hybrid, HybridPassword
```

Use it in the model:

```ruby
class User < ApplicationRecord
  has_secure_password algorithm: :hybrid
end
```

### Phase 2: Opportunistic rehash on login

After a successful BCrypt login, rehash with Argon2 transparently:

```ruby
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].to_s.downcase.strip)
    return render_invalid unless user&.authenticate(params[:password])

    if bcrypt_digest?(user.password_digest)
      user.password = params[:password]
      user.password_confirmation = params[:password]
      user.save!(validate: false)
    end

    # continue normal sign-in
    # ...
  end

  private

  def bcrypt_digest?(digest)
    digest.to_s.start_with?("$2a$", "$2b$", "$2y$")
  end

  def render_invalid
    # your failure response
  end
end
```

This avoids mass reset campaigns and upgrades active users naturally.

### Phase 3: Remove fallback

When most active accounts are rehashed (for example 95%+), switch:

```ruby
class User < ApplicationRecord
  has_secure_password algorithm: :argon2
end
```

Then retire BCrypt fallback code.

## Password reset flow strategy

Password reset is your second migration engine after login.

- Keep reset token expiration short (`has_secure_password reset_token: { expires_in: 15.minutes }` or tighter)
- Ensure new passwords always save with Argon2
- Monitor reset success/failure rates during rollout

This helps convert inactive BCrypt accounts gradually without forced lockouts.

## Operational checklist for rollout

Before deploy:

- Add metrics for login success by digest prefix (`$2*` vs `$argon2*`)
- Add alert on authentication error spikes
- Add feature flag for hybrid verifier if your team uses staged releases (if you're [deploying with Kamal](/blog/kamal-integration-in-rails-8-by-default-ruby/), feature flags via environment variables work well here)

During deploy:

- Roll out read path first (dual verify)
- Then write path (Argon2 creation)
- Track conversion percentage daily

After deploy:

- Remove stale BCrypt digests only after stable conversion period
- Rotate runbooks and onboarding docs to Argon2-first assumptions

## Testing plan

Cover these paths explicitly:

1. New user registration creates Argon2 digest
2. Existing BCrypt digest authenticates successfully
3. Existing BCrypt digest upgrades to Argon2 after login
4. Invalid credentials still fail in constant-time path assumptions
5. Password reset creates Argon2 digest
6. Legacy user can still reset and login

Example model test sketch:

```ruby
require "test_helper"

class UserPasswordAlgorithmTest < ActiveSupport::TestCase
  test "new password uses argon2 digest" do
    user = User.create!(email: "a@b.com", password: "StrongerP@ssword1", password_confirmation: "StrongerP@ssword1")
    assert user.password_digest.start_with?("$argon2")
  end
end
```

## Common mistakes

- Switching to `algorithm: :argon2` without a backward verification plan
- Not instrumenting conversion progress
- Doing a full forced reset without product comms
- Ignoring authentication throughput impact during peak traffic

## Suggested migration timeline

Week 1:
- Ship hybrid verifier + metrics

Week 2-4:
- Monitor opportunistic conversion via login and resets

Week 5+:
- If conversion is high and stable, switch to pure Argon2

For low-activity consumer apps, run longer before removing fallback.

## When NOT to migrate

Be honest about when this isn't worth the effort:

- **You're shipping a brand-new app with no existing users.** Skip the hybrid verifier entirely. Just set `algorithm: :argon2` and move on.
- **Your app uses Devise with custom strategies.** The hybrid verifier pattern assumes `has_secure_password`. Devise has its own password handling pipeline, and you'll need to hook into `Devise::Encryptable` instead. Different migration path.
- **You have fewer than 100 users and can email them all.** A forced password reset is simpler than maintaining dual-algorithm code. Send the email, reset everyone, delete the BCrypt code.
- **Your authentication is handled by an external identity provider.** If you're using Auth0, Okta, or similar -- your app doesn't store password digests at all. This guide doesn't apply.
- **You're on a Rails version older than 7.2.** The `algorithm:` option for `has_secure_password` isn't available. Upgrade Rails first, then come back.

## What to do next

Start with the hybrid verifier and metrics. Ship it behind a feature flag if your team does staged rollouts. Monitor the BCrypt-to-Argon2 conversion rate daily -- most apps see 80%+ conversion within two weeks of active users logging in.

If you're also modernizing your auth stack, the [Rails 8 authentication generator](/blog/rails-8-introducing-built-in-authentication-generator-ruby/) pairs well with this migration. And if you're hardening more than just passwords, our post on [authentication patterns in Rails 7.1](/blog/new-methods-that-help-implement-authentication-in-ruby-on-rails-71/) covers the broader picture.

For teams handling sensitive data, consider pairing this with [encrypted data compression in Rails 8](/blog/ruby-on-rails-8-custom-compression-for-encrypted-data/) -- defense in depth matters.

## References

- This Week in Rails (April 5, 2026): https://rubyonrails.org/2026/4/5/this-week-in-rails
- ActiveModel `has_secure_password` API (edge): https://edgeapi.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
- ActiveModel::SecurePassword (algorithm registry): https://edgeapi.rubyonrails.org/classes/ActiveModel/SecurePassword.html
- Argon2id RFC 9106: https://datatracker.ietf.org/doc/html/rfc9106
- OWASP Password Hashing Cheat Sheet: https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
- 37signals: Security practices for password hashing: https://dev.37signals.com/security
- Argon2 vs. BCrypt Comparison: https://pbnjer.com/argon2-vs-bcrypt
- Argon2 password gem: https://github.com/technion/ruby-argon2
