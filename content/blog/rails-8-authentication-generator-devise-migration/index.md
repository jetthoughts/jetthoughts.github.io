---
dev_to_id: null
title: "Rails 8 Authentication Generator: Complete Migration from Devise"
description: "Master the migration from Devise to Rails 8's built-in authentication system. Complete guide with step-by-step migration, security best practices, and production deployment strategies."
date: 2025-10-27
draft: false
tags: ["rails", "authentication", "devise", "security", "rails8"]
canonical_url: "https://jetthoughts.com/blog/rails-8-authentication-generator-devise-migration/"
cover_image: "cover.png"
slug: "rails-8-authentication-generator-devise-migration"
author: "JetThoughts Team"
metatags:
  image: cover.png
  og_title: "Rails 8 Authentication Generator: Complete Devise Migration | JetThoughts"
  og_description: "Master Rails 8 built-in authentication. Complete guide with Devise migration, security best practices, production deployment."
  twitter_title: "Rails 8 Authentication Generator: Devise Migration Guide"
  twitter_description: "Complete guide: Rails 8 authentication, Devise migration, security best practices, production deployment strategies"
---

Devise does 100 things. Rails 8's authentication generator does 8 things. That's not a limitation -- it's the point.

We've migrated three client apps off Devise in the past year. Every time, the codebase got smaller, the auth bugs disappeared, and nobody missed the 80% of Devise features they never used. The pattern is consistent: teams carry Devise's full weight -- 10+ modules, 200+ lines of initializer config, Warden middleware -- to get login, logout, and password reset. Rails 8 gives you exactly that, in code you can read in five minutes.

This post covers the real migration path: what's compatible (passwords transfer directly), what breaks (remember me, lockable, trackable need custom code), and the phased rollout strategy we use to avoid locking out production users.

## The Problem with Devise in Modern Rails Applications

Devise has been the default authentication choice for Rails since 2009. It's not bad software -- it's over-engineered software for most apps. Here's what we keep finding in client codebases.

### Complexity and Cognitive Overhead

Devise provides 10+ authentication modules, each with its own configuration, customization requirements, and edge cases:

```ruby
# config/initializers/devise.rb - Typical Devise configuration
Devise.setup do |config|
  config.mailer_sender = 'please-change-me@config.com'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.omniauth :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  # ... 50+ more configuration options
end
```

This 200+ line configuration file requires deep Devise knowledge to maintain safely. Most applications use only 20% of Devise's features yet carry 100% of its complexity.

### Hidden Behaviors and Magic

Devise introduces dozens of controller filters and helpers that operate invisibly:

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!  # What does this actually do?
end
```

Behind this single line:
- Multiple database queries checking session validity
- Cookie parsing and validation
- Warden strategy execution
- Session token verification
- Password timeout checks (if configured)
- Remember me functionality (if enabled)
- Two-factor authentication verification (if added)

Understanding and debugging these invisible operations requires deep Devise internals knowledge.

### Upgrade Challenges

Devise's complexity makes upgrades risky. Real-world example from a client migration:

```ruby
# Rails 6 → Rails 7 upgrade broke Devise
# Error: undefined method `persisted?' for nil:NilClass

# Root cause: Devise's Warden integration conflicted with Rails 7's
# session handling changes

# Required fixes:
# 1. Update Devise gem
# 2. Update Warden gem
# 3. Update Omniauth gems
# 4. Regenerate Devise configuration
# 5. Test all authentication flows
# 6. Update custom Devise modules
# 7. Migrate encrypted passwords (algorithm changes)
```

On a client project, this upgrade required significant development and testing time for what should have been a simple Rails version upgrade.

### Security Through Obscurity

Devise's complexity can obscure security vulnerabilities:

```ruby
# Real vulnerability found in production application
# devise.rb configuration
config.password_length = 6..128  # Too short!
config.stretches = 1             # Development setting in production!
config.expire_all_remember_me_on_sign_out = false  # Security risk!
```

On a client project, these misconfigurations went undetected until a security audit because they were buried in a 300-line initializer that no one fully understood.

### Performance Overhead

Devise's flexibility comes with runtime costs. A typical Devise `authenticate_user!` call executes 4-6 database queries per request (session lookup, token validation, trackable updates, etc.), while Rails 8's built-in authentication executes 1-2 queries. Rails 8 auth is simpler and has fewer database queries per request, but we have not published formal benchmarks comparing throughput.

For teams struggling with Devise complexity and seeking to modernize their authentication stack, our [technical leadership consulting](/services/technical-leadership-consulting/) helps evaluate whether Rails 8's built-in authentication meets your specific security requirements and business needs.

## Understanding Rails 8's Built-In Authentication

Rails 8's authentication system isn't trying to replace Devise feature-for-feature. It's asking a different question: what if you only shipped the auth features you actually use? For most apps, the answer is surprisingly little. If you haven't read the [overview of Rails 8's authentication generator](/blog/rails-8-introducing-built-in-authentication-generator-ruby/), start there for the high-level picture.

### Core Philosophy: Convention Over Framework

Rails 8 authentication follows "convention over configuration" principles:

```bash
# Generate complete authentication system
$ rails generate authentication

# This creates:
# - User model with has_secure_password
# - Session model for session tracking
# - Sessions controller for login/logout
# - Authentication concern for controllers
# - Migrations for users and sessions tables
```

That's it. No complex configuration files, no mysterious modules, no hidden behaviors. The foundation builds on [authentication helpers introduced in Rails 7.1](/blog/new-methods-that-help-implement-authentication-in-ruby-on-rails-71/) -- `generates_token_for`, `authenticate_by`, and `normalizes` -- so the patterns will feel familiar if you've already adopted those.

### Architecture: Simple and Transparent

#### Database Schema

```ruby
# db/migrate/[timestamp]_create_users.rb
class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
```

Clean, minimal, and explicit. No polymorphic associations, no STI, no unnecessary columns.

#### User Model

```ruby
# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }, if: :password_digest_changed?

  normalizes :email, with: -> email { email.strip.downcase }

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_digest&.last(10)
  end

  generates_token_for :email_confirmation, expires_in: 24.hours do
    email
  end
end
```

### What `has_secure_password` provides
- BCrypt password hashing with appropriate cost factor (and if you want Argon2id instead, see our [Argon2 migration guide](/blog/rails-argon2-has-secure-password-migration-guide/))
- `password` and `password_confirmation` virtual attributes
- `authenticate(password)` method for password verification
- Automatic password digest generation
- Password validation (presence, length, confirmation)

#### Sessions Controller

```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Signed out successfully"
  end
end
```

Transparent, understandable, and easy to customize. No hidden behaviors.

#### Current User Pattern

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  private

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def authenticate_user!
    redirect_to new_session_path, alert: "Please sign in" unless user_signed_in?
  end
end
```

Simple, explicit, and fully under your control.

### Security Features Built-In

#### Password Reset with Secure Tokens

```ruby
# app/controllers/passwords_controller.rb
class PasswordsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user
      # Generate secure token using Rails 7.1+ generates_token_for
      token = user.generate_token_for(:password_reset)

      # Send password reset email
      UserMailer.password_reset(user, token).deliver_later

      redirect_to root_path, notice: "Password reset instructions sent"
    else
      flash.now[:alert] = "Email not found"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by_token_for(:password_reset, params[:token])

    unless @user
      redirect_to new_password_path, alert: "Invalid or expired password reset link"
    end
  end

  def update
    @user = User.find_by_token_for(:password_reset, params[:token])

    if @user&.update(password_params)
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Password updated successfully"
    else
      flash.now[:alert] = "Could not update password"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
```

#### Email Confirmation

```ruby
# app/controllers/email_confirmations_controller.rb
class EmailConfirmationsController < ApplicationController
  def new
    @user = User.find_by_token_for(:email_confirmation, params[:token])

    if @user&.update(confirmed_at: Time.current)
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Email confirmed successfully"
    else
      redirect_to root_path, alert: "Invalid confirmation link"
    end
  end
end
```

#### Rate Limiting and Brute Force Protection

```ruby
# config/initializers/rack_attack.rb
class Rack::Attack
  # Throttle login attempts by email
  throttle("logins/email", limit: 5, period: 60.seconds) do |req|
    if req.path == "/session" && req.post?
      req.params['email'].to_s.downcase.gsub(/\s+/, "")
    end
  end

  # Throttle password reset requests
  throttle("password_resets/ip", limit: 3, period: 60.seconds) do |req|
    req.ip if req.path == "/passwords" && req.post?
  end
end

# config/application.rb
config.middleware.use Rack::Attack
```

### Extensibility: Build What You Need

Rails 8 authentication provides a foundation for adding advanced features:

#### Two-Factor Authentication (TOTP)

```ruby
# Gemfile
gem 'rotp'  # Ruby One Time Password library

# db/migrate/[timestamp]_add_otp_to_users.rb
class AddOtpToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :otp_secret, :string
    add_column :users, :otp_enabled, :boolean, default: false
  end
end

# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  def enable_two_factor!
    self.otp_secret = ROTP::Base32.random
    self.otp_enabled = true
    save!
  end

  def verify_otp(code)
    return false unless otp_enabled?
    totp = ROTP::TOTP.new(otp_secret)
    totp.verify(code, drift_behind: 15, drift_ahead: 15)
  end

  def provisioning_uri
    ROTP::TOTP.new(otp_secret).provisioning_uri(email)
  end
end

# app/controllers/two_factors_controller.rb
class TwoFactorsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @provisioning_uri = @user.provisioning_uri
  end

  def create
    if current_user.enable_two_factor!
      redirect_to two_factor_path, notice: "Two-factor authentication enabled"
    else
      redirect_to new_two_factor_path, alert: "Could not enable two-factor"
    end
  end
end
```

#### OAuth Integration (Google/GitHub/etc.)

```ruby
# Gemfile
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'

# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
end

# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  # Allow users without passwords (OAuth-only accounts)
  validates :password, length: { minimum: 12 }, if: :password_required?

  private

  def password_required?
    password_digest.nil? || password.present?
  end
end

# app/controllers/oauth_callbacks_controller.rb
class OauthCallbacksController < ApplicationController
  def google
    auth = request.env['omniauth.auth']
    user = User.find_or_create_by(email: auth['info']['email']) do |u|
      u.password = SecureRandom.hex(32)  # Random password for OAuth users
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: "Signed in with Google"
  end

  def github
    # Similar implementation for GitHub
  end

  def failure
    redirect_to new_session_path, alert: "Authentication failed"
  end
end
```

#### Session Management and Device Tracking

```ruby
# db/migrate/[timestamp]_create_sessions.rb
class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, null: false
      t.string :ip_address
      t.string :user_agent
      t.datetime :last_accessed_at

      t.timestamps
    end

    add_index :sessions, :token, unique: true
  end
end

# app/models/session.rb
class Session < ApplicationRecord
  belongs_to :user

  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(32)
  end
end

# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session_record = user.sessions.create!(
        ip_address: request.remote_ip,
        user_agent: request.user_agent,
        last_accessed_at: Time.current
      )

      session[:session_token] = session_record.token
      redirect_to root_path, notice: "Signed in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end
end
```

### Performance Characteristics

Rails 8's built-in authentication has fewer dependencies and executes fewer database queries per request than Devise. Dropping Devise, Warden, and their transitive dependencies also reduces memory usage per Rails process. If you're also moving to [Solid Cache](/blog/rails-8-solid-cache-performance-redis-migration/) and [Solid Queue](/blog/rails-8-solid-queue-migration-guide/), the combined dependency reduction is significant.

## Step-by-Step Migration from Devise to Rails 8 Authentication

Migrating from Devise to Rails 8's built-in authentication requires careful planning to preserve user sessions, maintain data integrity, and avoid service disruption. This step-by-step guide ensures a smooth transition.

### Phase 1: Pre-Migration Assessment

#### Inventory Current Devise Configuration

```bash
# Audit your Devise setup
$ grep -r "devise" Gemfile
$ cat config/initializers/devise.rb | wc -l  # How many lines of config?
$ grep -r "devise_for" config/routes.rb
$ find app -name "*.rb" -exec grep -l "devise" {} \;
```

Document which Devise modules you're using:

```ruby
# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :trackable, :omniauthable

  # Which modules are actually being used?
end
```

#### Map Devise Features to Rails 8 Equivalents

```ruby
devise_to_rails8_mapping = {
  database_authenticatable: "Built-in (has_secure_password)",
  registerable: "Built-in (registration controller)",
  recoverable: "Built-in (passwords controller)",
  rememberable: "Custom implementation needed",
  validatable: "Built-in (model validations)",
  confirmable: "Built-in (email confirmations controller)",
  lockable: "Custom implementation needed",
  timeoutable: "Custom implementation needed",
  trackable: "Custom implementation needed",
  omniauthable: "OmniAuth gem integration"
}
```

#### Assess Migration Complexity

```ruby
# Calculate migration effort
assessment = {
  users_count: User.count,
  devise_modules: 6,  # From your user model
  custom_controllers: Dir["app/controllers/**/users/**/*.rb"].count,
  custom_views: Dir["app/views/devise/**/*.erb"].count,
  password_encryption: "bcrypt",  # Check devise.rb
  estimated_hours: 40  # Baseline for medium complexity
}
```

### Phase 2: Preparing Your Application

#### Create Parallel Authentication System

Don't remove Devise immediately. Build Rails 8 authentication alongside it:

```bash
# Generate Rails 8 authentication
$ rails generate authentication

# This creates new controllers, but don't touch Devise yet
# New files:
# - app/controllers/sessions_controller.rb (new)
# - app/controllers/passwords_controller.rb (new)
# - app/models/concerns/authenticatable.rb (new)
```

#### Rename to avoid conflicts:

```bash
$ mv app/controllers/sessions_controller.rb app/controllers/rails8_sessions_controller.rb
$ mv app/controllers/passwords_controller.rb app/controllers/rails8_passwords_controller.rb
```

#### Add Rails 8 Authentication Columns

```ruby
# db/migrate/[timestamp]_add_rails8_auth_to_users.rb
class AddRails8AuthToUsers < ActiveRecord::Migration[8.0]
  def change
    # Don't rename encrypted_password yet - keep both during migration
    # Guard against existing columns (for Devise apps)
    add_column :users, :password_digest, :string unless column_exists?(:users, :password_digest)
    add_column :users, :confirmed_at, :datetime unless column_exists?(:users, :confirmed_at)
    add_column :users, :confirmation_sent_at, :datetime unless column_exists?(:users, :confirmation_sent_at)
  end
end
```

#### Migrate Password Hashes

Devise uses `encrypted_password` with BCrypt. Rails 8's `has_secure_password` uses `password_digest` with BCrypt. They're compatible!

```ruby
# lib/tasks/migrate_passwords.rake
namespace :auth do
  desc "Migrate Devise encrypted_password to Rails 8 password_digest"
  task migrate_passwords: :environment do
    User.find_each do |user|
      if user.encrypted_password.present? && user.password_digest.nil?
        user.update_column(:password_digest, user.encrypted_password)
      end
    end

    puts "Migrated #{User.where.not(password_digest: nil).count} passwords"
  end
end

$ bin/rails auth:migrate_passwords
```

#### Test Password Authentication Compatibility

```ruby
# rails console
user = User.first

# Test Devise authentication still works
user.valid_password?("password123")  # => true

# Test Rails 8 authentication works with same password
user.authenticate("password123")  # => #<User id: 1...>
```

### Phase 3: Implementing Rails 8 Authentication

#### Update User Model

```ruby
# app/models/user.rb
class User < ApplicationRecord
  # Keep Devise temporarily
  devise :database_authenticatable, :registerable, :recoverable

  # Add Rails 8 authentication
  has_secure_password validations: false  # Disable auto-validations to avoid conflicts

  # Custom validations
  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }, allow_nil: true,
            if: :password_digest_changed?

  normalizes :email, with: -> email { email.strip.downcase }

  # Token generation for password reset and email confirmation
  generates_token_for :password_reset, expires_in: 15.minutes do
    password_digest&.last(10)
  end

  generates_token_for :email_confirmation, expires_in: 24.hours do
    email
  end
end
```

#### Create Rails 8 Controllers

```ruby
# app/controllers/rails8_sessions_controller.rb
class Rails8SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # Use different session key to avoid conflicts
      session[:rails8_user_id] = user.id
      redirect_to root_path, notice: "Signed in with Rails 8 auth"
    else
      flash.now[:alert] = "Invalid credentials"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:rails8_user_id)
    redirect_to root_path, notice: "Signed out"
  end
end
```

#### Dual Authentication Helper

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  private

  def current_user
    # Try Rails 8 auth first, fall back to Devise
    @current_user ||= rails8_current_user || devise_current_user
  end
  helper_method :current_user

  def rails8_current_user
    return unless session[:rails8_user_id]
    @rails8_current_user ||= User.find_by(id: session[:rails8_user_id])
  end

  def devise_current_user
    # Devise's current_user method
    super
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?
end
```

#### Add Feature Flag for Gradual Rollout

```ruby
# lib/auth_migration.rb
class AuthMigration
  def self.use_rails8_auth?(user)
    # Gradual rollout: 10% of users, then increase
    Digest::MD5.hexdigest(user.id.to_s).to_i(16) % 100 < rollout_percentage
  end

  def self.rollout_percentage
    ENV.fetch('RAILS8_AUTH_ROLLOUT', '10').to_i
  end
end

# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && AuthMigration.use_rails8_auth?(user)
      # Redirect to Rails 8 authentication
      # SECURITY: Never forward raw params (contains password)
      redirect_to rails8_session_path(email: params[:email])
    else
      # Use Devise authentication
      super
    end
  end
end
```

### Phase 4: Data Migration and Validation

#### Migrate Confirmable Data

```ruby
# lib/tasks/migrate_confirmable.rake
namespace :auth do
  desc "Migrate Devise confirmable data"
  task migrate_confirmable: :environment do
    User.where.not(confirmed_at: nil).find_each do |user|
      # Devise confirmed_at → Rails 8 confirmed_at
      user.update_column(:confirmed_at, user.confirmed_at) if user.confirmed_at
    end

    puts "Migrated confirmation data for #{User.where.not(confirmed_at: nil).count} users"
  end
end
```

#### Test Authentication Flows

```ruby
# spec/features/authentication_spec.rb
RSpec.describe "Authentication migration", type: :feature do
  let(:user) { create(:user, email: "test@example.com", password: "SecurePassword123!") }

  describe "sign in flow" do
    it "works with Rails 8 authentication" do
      visit rails8_new_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: "SecurePassword123!"
      click_button "Sign in"

      expect(page).to have_content "Signed in successfully"
      expect(current_path).to eq root_path
    end

    it "maintains Devise authentication" do
      visit new_user_session_path  # Devise path

      fill_in "Email", with: user.email
      fill_in "Password", with: "SecurePassword123!"
      click_button "Sign in"

      expect(page).to have_content "Signed in successfully"
    end
  end

  describe "password reset flow" do
    it "works with Rails 8" do
      visit rails8_new_password_path

      fill_in "Email", with: user.email
      click_button "Send reset instructions"

      expect(page).to have_content "Password reset instructions sent"
    end
  end
end
```

#### Verify Data Integrity

```ruby
# lib/tasks/verify_migration.rake
namespace :auth do
  desc "Verify authentication migration data integrity"
  task verify: :environment do
    checks = {
      users_with_password_digest: User.where.not(password_digest: nil).count,
      users_with_encrypted_password: User.where.not(encrypted_password: nil).count,
      users_confirmed: User.where.not(confirmed_at: nil).count,
      password_compatibility: 0
    }

    # Test password compatibility (read-only validation)
    User.limit(100).each do |user|
      next unless user.encrypted_password.present?

      # Validate digest format without mutating user data
      if user.password_digest.present? && user.encrypted_password.present?
        # Check that both digests exist and are properly formatted
        if BCrypt::Password.valid_hash?(user.password_digest) &&
           user.encrypted_password.start_with?('$2a$')
          checks[:password_compatibility] += 1
        end
      end
    end

    puts JSON.pretty_generate(checks)

    if checks[:users_with_password_digest] != checks[:users_with_encrypted_password]
      raise "Password migration incomplete!"
    end
  end
end
```

### Phase 5: Switching Over to Rails 8

#### Gradual Traffic Migration

```ruby
# config/initializers/auth_rollout.rb
class AuthRollout
  ROLLOUT_SCHEDULE = {
    week_1: 10,   # 10% of traffic
    week_2: 25,   # 25% of traffic
    week_3: 50,   # 50% of traffic
    week_4: 75,   # 75% of traffic
    week_5: 100   # 100% of traffic (complete migration)
  }

  def self.current_percentage
    ENV.fetch('AUTH_ROLLOUT_PERCENTAGE', '10').to_i
  end

  def self.use_rails8_auth?(user_id)
    Digest::MD5.hexdigest(user_id.to_s).to_i(16) % 100 < current_percentage
  end
end
```

#### Update Routes

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Rails 8 authentication routes (new)
  resource :session, only: [:new, :create, :destroy]
  resources :passwords, only: [:new, :create, :edit, :update]
  resources :registrations, only: [:new, :create]

  # Keep Devise routes temporarily
  devise_for :users

  # Root and other routes...
end
```

#### Monitor Migration Progress

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  around_action :track_auth_method

  private

  def track_auth_method
    auth_method = if session[:rails8_user_id]
      'rails8'
    elsif user_signed_in?  # Devise
      'devise'
    else
      'anonymous'
    end

    Rails.logger.info "Auth method: #{auth_method} for request #{request.path}"

    # Send to monitoring system (e.g., New Relic, DataDog)
    StatsD.increment("auth.method.#{auth_method}")

    yield
  end
end
```

#### Remove Devise (Final Step)

Once 100% of traffic is on Rails 8 authentication and monitoring confirms stability:

```ruby
# 1. Remove Devise gem
# Gemfile
# gem 'devise'  # Remove this line

$ bundle install

# 2. Remove Devise configuration
$ rm config/initializers/devise.rb
$ rm config/locales/devise.en.yml

# 3. Remove Devise routes
# config/routes.rb
# Remove: devise_for :users

# 4. Clean up User model
# app/models/user.rb
class User < ApplicationRecord
  # Remove: devise :database_authenticatable, ...

  has_secure_password

  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }, if: :password_digest_changed?

  normalizes :email, with: -> email { email.strip.downcase }
end

# 5. Drop Devise columns (after thorough testing)
# db/migrate/[timestamp]_remove_devise_columns.rb
class RemoveDeviseColumns < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :encrypted_password, :string
    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_sent_at, :datetime
    remove_column :users, :remember_created_at, :datetime
    remove_column :users, :sign_in_count, :integer
    remove_column :users, :current_sign_in_at, :datetime
    remove_column :users, :last_sign_in_at, :datetime
    remove_column :users, :current_sign_in_ip, :string
    remove_column :users, :last_sign_in_ip, :string
    remove_column :users, :confirmation_token, :string
    remove_column :users, :unconfirmed_email, :string
  end
end
```

## Production Deployment and Security Considerations

Migrating authentication systems in production requires careful attention to security, monitoring, and rollback procedures.

### Security Hardening

#### Implement Rate Limiting

```ruby
# Gemfile
gem 'rack-attack'

# config/initializers/rack_attack.rb
class Rack::Attack
  # Throttle login attempts by email
  throttle("logins/email", limit: 5, period: 20.seconds) do |req|
    if req.path == "/session" && req.post?
      req.params['email'].to_s.downcase.gsub(/\s+/, "")
    end
  end

  # Throttle login attempts by IP
  throttle("logins/ip", limit: 10, period: 60.seconds) do |req|
    req.ip if req.path == "/session" && req.post?
  end

  # Throttle password reset requests
  throttle("password_resets/ip", limit: 3, period: 60.seconds) do |req|
    req.ip if req.path == "/passwords" && req.post?
  end

  # Block IPs with suspicious activity
  blocklist("bad_actors") do |req|
    BadActorList.include?(req.ip)
  end
end
```

#### Secure Session Configuration

```ruby
# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store,
  key: '_myapp_session',
  secure: Rails.env.production?,  # HTTPS only in production
  httponly: true,                 # Prevent JavaScript access
  same_site: :lax,                # CSRF protection
  expire_after: 2.weeks           # Session expiration
```

#### Password Strength Enforcement

```ruby
# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  validate :password_complexity

  private

  def password_complexity
    return if password.blank?

    errors.add :password, "must include at least one lowercase letter" unless password.match(/[a-z]/)
    errors.add :password, "must include at least one uppercase letter" unless password.match(/[A-Z]/)
    errors.add :password, "must include at least one digit" unless password.match(/\d/)
    errors.add :password, "must include at least one special character" unless password.match(/[^A-Za-z0-9]/)
  end
end
```

#### Implement Account Lockout

```ruby
# db/migrate/[timestamp]_add_lockout_to_users.rb
class AddLockoutToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :failed_login_attempts, :integer, default: 0
    add_column :users, :locked_at, :datetime
  end
end

# app/models/user.rb
class User < ApplicationRecord
  MAX_LOGIN_ATTEMPTS = 5
  LOCKOUT_DURATION = 30.minutes

  def increment_failed_login!
    increment!(:failed_login_attempts)

    if failed_login_attempts >= MAX_LOGIN_ATTEMPTS
      update!(locked_at: Time.current)
    end
  end

  def reset_failed_login!
    update!(failed_login_attempts: 0, locked_at: nil)
  end

  def locked?
    locked_at.present? && locked_at > LOCKOUT_DURATION.ago
  end
end

# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.locked?
      flash.now[:alert] = "Account locked due to too many failed login attempts"
      render :new, status: :unprocessable_entity
      return
    end

    if user&.authenticate(params[:password])
      user.reset_failed_login!
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed in successfully"
    else
      user&.increment_failed_login!
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end
end
```

### Monitoring and Alerting

#### Authentication Metrics Dashboard

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  around_action :track_authentication_metrics

  private

  def track_authentication_metrics
    start = Time.current

    yield

    duration = Time.current - start

    if user_signed_in?
      StatsD.timing("auth.login_duration", duration * 1000)
      StatsD.increment("auth.successful_login")
    end
  rescue => e
    StatsD.increment("auth.error.#{e.class.name}")
    raise
  end
end
```

#### Failed Login Monitoring

```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # Success
      session[:user_id] = user.id
      log_successful_login(user)
    else
      # Failure
      log_failed_login(params[:email], request.ip)
      flash.now[:alert] = "Invalid credentials"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def log_successful_login(user)
    Rails.logger.info "Successful login: user_id=#{user.id} ip=#{request.ip}"
    StatsD.increment("auth.login.success")
  end

  def log_failed_login(email, ip)
    Rails.logger.warn "Failed login: email=#{email} ip=#{ip}"
    StatsD.increment("auth.login.failure")

    # Alert on suspicious activity
    if FailedLoginTracker.suspicious?(email, ip)
      Sentry.capture_message("Suspicious login activity detected",
        extra: { email: email, ip: ip })
    end
  end
end
```

#### Security Audit Logging

```ruby
# app/models/audit_log.rb
class AuditLog < ApplicationRecord
  belongs_to :user, optional: true

  enum event_type: {
    login: 0,
    logout: 1,
    password_change: 2,
    password_reset_request: 3,
    email_confirmation: 4,
    account_locked: 5,
    account_unlocked: 6
  }

  def self.log_event(event_type, user: nil, metadata: {})
    create!(
      event_type: event_type,
      user: user,
      metadata: metadata.merge(
        ip_address: Current.ip_address,
        user_agent: Current.user_agent,
        timestamp: Time.current
      )
    )
  end
end

# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      AuditLog.log_event(:login, user: user)
      redirect_to root_path
    else
      AuditLog.log_event(:login, metadata: { email: params[:email], success: false })
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    AuditLog.log_event(:logout, user: current_user)
    session.delete(:user_id)
    redirect_to root_path
  end
end
```

### Rollback Strategy

#### Maintain Dual Authentication During Rollout

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  private

  def current_user
    @current_user ||= begin
      # Try Rails 8 authentication first
      if session[:rails8_user_id]
        User.find_by(id: session[:rails8_user_id])
      # Fall back to Devise if Rails 8 user not found
      elsif defined?(Devise) && respond_to?(:devise_current_user)
        devise_current_user
      end
    end
  end
  helper_method :current_user
end
```

#### Instant Rollback Capability

```ruby
# lib/auth_rollback.rb
class AuthRollback
  def self.execute!
    # Stop using Rails 8 authentication immediately
    ENV['RAILS8_AUTH_ENABLED'] = 'false'

    # Clear Rails 8 sessions
    Redis.current.keys("session:rails8:*").each do |key|
      Redis.current.del(key)
    end

    # Log rollback event
    Rails.logger.error "Authentication rollback executed at #{Time.current}"
    Sentry.capture_message("Authentication system rolled back to Devise")

    true
  end
end

# Can be triggered via Rails console or admin interface
$ rails runner "AuthRollback.execute!"
```

### Production Deployment Checklist

#### Pre-Deployment:
- [ ] Complete data migration (passwords, confirmations)
- [ ] Verify test suite passes (100% of authentication tests)
- [ ] Security audit completed (penetration testing, code review)
- [ ] Monitoring dashboards configured
- [ ] Rollback procedure documented and tested
- [ ] Team training completed

#### Deployment (Gradual Rollout):
- [ ] Week 1: Enable for 10% of users
- [ ] Monitor error rates, failed logins, support tickets
- [ ] Week 2: Increase to 25% if metrics healthy
- [ ] Week 3: Increase to 50%
- [ ] Week 4: Increase to 75%
- [ ] Week 5: Complete migration to 100%

#### Post-Deployment:
- [ ] Monitor authentication metrics for 30 days
- [ ] Verify no increase in failed logins
- [ ] Confirm password reset flow working correctly
- [ ] Remove Devise gem and dependencies
- [ ] Clean up database (remove unused Devise columns)
- [ ] Update documentation

## When NOT to Migrate Off Devise

Not every app should make this move. Stay on Devise if:

- **You need OAuth as a core feature.** Rails 8 auth doesn't include OAuth. You can wire up OmniAuth yourself (we showed how above), but if you support 5+ OAuth providers with account linking, Devise's omniauthable module saves real time.
- **You have 20+ custom auth flows.** Lockable, timeoutable, trackable, confirmable with re-confirmation, remember-me with token rotation -- if you actively use most of Devise's modules, rebuilding them all is a month of work with diminishing returns.
- **Your app is stable and auth isn't causing problems.** Migration carries risk. If Devise works, your team understands it, and you're not hitting performance issues, the migration cost may exceed the benefit. Ship features instead.
- **You're mid-upgrade to Rails 7.** Finish the Rails upgrade first. Swapping auth systems and Rails versions simultaneously is how you end up locked out of production on a Friday night.

The honest test: count how many Devise modules your User model actually declares, then count how many your app exercises in production. If the gap is small, Devise is earning its keep.

---

## What to Do Next

If you're starting fresh on Rails 8, skip Devise entirely. Run `rails generate authentication` and build only what you need.

If you're migrating, start with Phase 1: audit your Devise usage and map it to Rails 8 equivalents. The password hashes are compatible -- that's the hardest part already solved. Run dual auth in production for at least two weeks before cutting over.

For related reading: our [Argon2 migration guide](/blog/rails-argon2-has-secure-password-migration-guide/) covers upgrading password hashing beyond BCrypt, and the [Rails 8 authentication generator overview](/blog/rails-8-introducing-built-in-authentication-generator-ruby/) walks through the generated code in detail.

For teams undertaking auth migrations or needing security guidance, our [Rails development team](/services/app-web-development/) has done this migration three times in production -- we can help you avoid the sharp edges.
