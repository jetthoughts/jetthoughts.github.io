---
title: "Ruby on Rails testing strategy: From unit tests to integration"
description: "Tired of bugs slipping through to production? Here's your complete guide to building a comprehensive Rails testing strategy that catches issues before your users do."
date: 2024-09-17
tags: ["Ruby on Rails", "Testing", "RSpec", "Rails testing", "TDD", "Integration testing"]
categories: ["Development", "Testing"]
author: "JetThoughts Team"
slug: "ruby-on-rails-testing-strategy-unit-tests-integration"
canonical_url: "https://jetthoughts.com/blog/ruby-on-rails-testing-strategy-unit-tests-integration/"
meta_title: "Rails Testing Strategy: Complete Guide to Unit & Integration Tests | JetThoughts"
meta_description: "Master Rails testing with our comprehensive guide covering unit tests, integration testing, TDD workflow, and CI/CD integration. Build bulletproof Rails apps."
---

## The Challenge

Tired of bugs slipping through to production? Stressed about deploying changes that might break existing features?

## Our Approach

Let's build a bulletproof testing strategy that catches issues before your users ever see them

Have you ever deployed what seemed like a simple change, only to get a panicked call that half your app is broken? We've all been there. That sinking feeling when you realize a small tweak to one feature accidentally broke something completely unrelated.

The solution isn't to stop making changes – it's to build a comprehensive testing strategy that gives you confidence in every deployment. Let's walk through how to create a testing approach that scales with your Rails application.

## Testing pyramid for Rails apps

A good testing strategy follows the testing pyramid: lots of fast unit tests, some integration tests, and a few end-to-end tests.

### Understanding the testing pyramid

Here's how the pyramid works for Rails applications:

### Rails testing pyramid structure

```
# Fast and numerous - 70% of your tests
Unit Tests (Models, Services, Helpers)
├── Model validations and associations
├── Business logic in service objects
├── Helper methods
└── Controller actions (isolated)

# Moderate speed and coverage - 25% of your tests
Integration Tests (Request specs, Feature specs)
├── API endpoint testing
├── User workflow testing
├── Component integration
└── Database interactions

# Slow but comprehensive - 5% of your tests
End-to-End Tests (System specs, Browser tests)
├── Critical user journeys
├── JavaScript interactions
├── Cross-browser compatibility
└── Full application workflows
```

### Setting up your Rails testing environment

Let's get your testing foundation right:

### Essential testing gems

```ruby
# Gemfile
group :development, :test do
  gem 'rspec-rails', '~> 6.0'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers'
  gem 'timecop' # For time-based testing
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webmock' # Mock external HTTP requests
  gem 'vcr' # Record HTTP interactions
  gem 'simplecov', require: false # Code coverage
end

# Install and configure
rails generate rspec:install
```

### Configure RSpec for optimal performance

### RSpec configuration

```ruby
# spec/rails_helper.rb
require 'spec_helper'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'

# Configure database cleaner
require 'database_cleaner/active_record'

RSpec.configure do |config|
  # Use transactional fixtures for speed
  config.use_transactional_fixtures = true

  # Include factory_bot methods
  config.include FactoryBot::Syntax::Methods

  # Include shoulda matchers
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  # Database cleaner configuration
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # Filter lines from Rails gems in backtraces
  config.filter_rails_from_backtrace!

  # Run specs in random order to surface order dependencies
  config.order = :random
  Kernel.srand config.seed
end

# spec/spec_helper.rb
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/vendor/'

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Services', 'app/services'
  add_group 'Jobs', 'app/jobs'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
```

## Unit testing with RSpec

Unit tests are your first line of defense. They're fast, focused, and catch regressions early.

### Testing models thoroughly

Models contain your business logic, so test them well:

### Comprehensive model testing
# spec/models/user_spec.rb
RSpec.describe User, type: :model do
  # Test associations
  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_one(:profile).dependent(:destroy) }
  end

  # Test validations
  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid-email').for(:email) }
  end

  # Test scopes
  describe 'scopes' do
    let!(:active_user) { create(:user, :active) }
    let!(:inactive_user) { create(:user, :inactive) }

    describe '.active' do
      it 'returns only active users' do
        expect(User.active).to include(active_user)
        expect(User.active).not_to include(inactive_user)
      end
    end

    describe '.created_last_week' do
      let!(:recent_user) { create(:user, created_at: 3.days.ago) }
      let!(:old_user) { create(:user, created_at: 2.weeks.ago) }

      it 'returns users created in the last week' do
        expect(User.created_last_week).to include(recent_user)
        expect(User.created_last_week).not_to include(old_user)
      end
    end
  end

  # Test instance methods
  describe '#full_name' do
    let(:user) { build(:user, first_name: 'John', last_name: 'Doe') }

    it 'returns the concatenated first and last name' do
      expect(user.full_name).to eq('John Doe')
    end

    context 'when last name is missing' do
      let(:user) { build(:user, first_name: 'John', last_name: nil) }

      it 'returns just the first name' do
        expect(user.full_name).to eq('John')
      end
    end
  end

  # Test callbacks
  describe 'callbacks' do
    describe 'after_create' do
      it 'sends welcome email' do
        expect(UserMailer).to receive(:welcome).and_call_original
        expect_any_instance_of(ActionMailer::MessageDelivery).to receive(:deliver_later)

        create(:user)
      end

      it 'creates a profile' do
        user = create(:user)
        expect(user.profile).to be_present
      end
    end
  end

  # Test custom methods with edge cases
  describe '#can_post?' do
    context 'when user is active and verified' do
      let(:user) { create(:user, :active, :verified) }

      it 'returns true' do
        expect(user.can_post?).to be true
      end
    end

    context 'when user is not verified' do
      let(:user) { create(:user, :active, verified: false) }

      it 'returns false' do
        expect(user.can_post?).to be false
      end
    end

    context 'when user is suspended' do
      let(:user) { create(:user, :suspended) }

      it 'returns false' do
        expect(user.can_post?).to be false
      end
    end
  end
end

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    verified { true }
    status { 'active' }

    trait :active do
      status { 'active' }
    end

    trait :inactive do
      status { 'inactive' }
    end

    trait :suspended do
      status { 'suspended' }
    end

    trait :verified do
      verified { true }
      verified_at { 1.day.ago }
    end

    trait :unverified do
      verified { false }
      verified_at { nil }
    end

    # Create associated records when needed
    trait :with_posts do
      after(:create) do |user|
        create_list(:post, 3, author: user)
      end
    end
  end
end
```

### Testing services and business logic

Service objects encapsulate complex business logic and deserve thorough testing:

### Service object testing

```ruby
# app/services/user_registration_service.rb
class UserRegistrationService
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string
  attribute :password, :string
  attribute :first_name, :string
  attribute :last_name, :string

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, :last_name, presence: true

  def call
    return false unless valid?

    ActiveRecord::Base.transaction do
      create_user!
      send_welcome_email
      track_registration
    end

    true
  rescue StandardError => e
    Rails.logger.error "User registration failed: #{e.message}"
    errors.add(:base, 'Registration failed. Please try again.')
    false
  end

  attr_reader :user

  private

  def create_user!
    @user = User.create!(
      email: email,
      password: password,
      first_name: first_name,
      last_name: last_name
    )
  end

  def send_welcome_email
    UserMailer.welcome(user).deliver_later
  end

  def track_registration
    AnalyticsService.track(
      user_id: user.id,
      event: 'user_registered',
      properties: { source: 'web' }
    )
  end
end

# spec/services/user_registration_service_spec.rb
RSpec.describe UserRegistrationService do
  let(:valid_params) do
    {
      email: 'user@example.com',
      password: 'password123',
      first_name: 'John',
      last_name: 'Doe'
    }
  end

  describe '#call' do
    context 'with valid parameters' do
      let(:service) { described_class.new(valid_params) }

      it 'creates a new user' do
        expect { service.call }.to change(User, :count).by(1)
      end

      it 'returns true' do
        expect(service.call).to be true
      end

      it 'sets the user attribute' do
        service.call
        expect(service.user).to be_a(User)
        expect(service.user.email).to eq('user@example.com')
      end

      it 'sends welcome email' do
        expect(UserMailer).to receive(:welcome).and_call_original
        expect_any_instance_of(ActionMailer::MessageDelivery).to receive(:deliver_later)

        service.call
      end

      it 'tracks registration analytics' do
        expect(AnalyticsService).to receive(:track).with(
          user_id: anything,
          event: 'user_registered',
          properties: { source: 'web' }
        )

        service.call
      end
    end

    context 'with invalid email' do
      let(:service) { described_class.new(valid_params.merge(email: 'invalid')) }

      it 'does not create a user' do
        expect { service.call }.not_to change(User, :count)
      end

      it 'returns false' do
        expect(service.call).to be false
      end

      it 'adds validation errors' do
        service.call
        expect(service.errors[:email]).to be_present
      end
    end

    context 'when user creation fails' do
      before do
        allow(User).to receive(:create!).and_raise(ActiveRecord::RecordInvalid.new(User.new))
      end

      let(:service) { described_class.new(valid_params) }

      it 'handles the exception gracefully' do
        expect(service.call).to be false
      end

      it 'adds base error' do
        service.call
        expect(service.errors[:base]).to include('Registration failed. Please try again.')
      end

      it 'does not send welcome email' do
        expect(UserMailer).not_to receive(:welcome)
        service.call
      end
    end

    context 'when email delivery fails' do
      before do
        allow(UserMailer).to receive(:welcome).and_raise(StandardError.new('Email service down'))
      end

      let(:service) { described_class.new(valid_params) }

      it 'rolls back user creation' do
        expect { service.call }.not_to change(User, :count)
      end

      it 'returns false' do
        expect(service.call).to be false
      end
    end
  end

  describe 'validations' do
    it 'validates email format' do
      service = described_class.new(valid_params.merge(email: 'invalid'))
      expect(service).not_to be_valid
      expect(service.errors[:email]).to be_present
    end

    it 'validates password length' do
      service = described_class.new(valid_params.merge(password: '123'))
      expect(service).not_to be_valid
      expect(service.errors[:password]).to be_present
    end

    it 'validates required fields' do
      service = described_class.new({})
      expect(service).not_to be_valid
      expect(service.errors[:email]).to be_present
      expect(service.errors[:password]).to be_present
      expect(service.errors[:first_name]).to be_present
      expect(service.errors[:last_name]).to be_present
    end
  end
end
```

> **💡 Tip:** Test edge cases and error conditions as thoroughly as the happy path. Your users will find these edge cases in production!

## Integration testing strategies

Integration tests ensure your components work together correctly.

### Request specs for API testing

Test your API endpoints thoroughly:

### Comprehensive request specs

```ruby
# spec/requests/api/v1/posts_spec.rb
RSpec.describe 'Posts API', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:auth_headers) { { 'Authorization' => "Bearer #{jwt_token(user)}" } }

  describe 'GET /api/v1/posts' do
    let!(:published_posts) { create_list(:post, 3, :published) }
    let!(:draft_posts) { create_list(:post, 2, :draft) }

    context 'without authentication' do
      it 'returns published posts only' do
        get '/api/v1/posts'

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)

        expect(json['data'].length).to eq(3)
        expect(json['data'].all? { |post| post['published'] }).to be true
      end
    end

    context 'with authentication' do
      it 'includes pagination headers' do
        create_list(:post, 25, :published)

        get '/api/v1/posts', headers: auth_headers

        expect(response.headers['X-Total-Count']).to be_present
        expect(response.headers['X-Page']).to eq('1')
        expect(response.headers['X-Per-Page']).to eq('20')
      end

      it 'filters by author when requested' do
        my_posts = create_list(:post, 2, :published, author: user)
        other_posts = create_list(:post, 2, :published, author: other_user)

        get '/api/v1/posts', params: { author_id: user.id }, headers: auth_headers

        json = JSON.parse(response.body)
        returned_ids = json['data'].map { |post| post['id'] }

        expect(returned_ids).to match_array(my_posts.map(&:id))
        expect(returned_ids).not_to include(*other_posts.map(&:id))
      end
    end

    context 'with invalid parameters' do
      it 'handles invalid pagination gracefully' do
        get '/api/v1/posts', params: { page: -1 }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['data']).to be_an(Array)
      end
    end
  end

  describe 'POST /api/v1/posts' do
    let(:valid_params) do
      {
        post: {
          title: 'Test Post',
          content: 'This is test content',
          published: true
        }
      }
    end

    context 'with valid authentication and parameters' do
      it 'creates a new post' do
        expect {
          post '/api/v1/posts', params: valid_params, headers: auth_headers
        }.to change(Post, :count).by(1)

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)
        expect(json['data']['title']).to eq('Test Post')
        expect(json['data']['author_id']).to eq(user.id)
      end

      it 'sanitizes content properly' do
        malicious_params = valid_params.deep_merge(
          post: { content: '<script>alert("xss")</script>Safe content' }
        )

        post '/api/v1/posts', params: malicious_params, headers: auth_headers

        json = JSON.parse(response.body)
        expect(json['data']['content']).not_to include('<script>')
        expect(json['data']['content']).to include('Safe content')
      end
    end

    context 'without authentication' do
      it 'returns unauthorized' do
        post '/api/v1/posts', params: valid_params

        expect(response).to have_http_status(:unauthorized)
        json = JSON.parse(response.body)
        expect(json['error']).to be_present
      end
    end

    context 'with invalid parameters' do
      it 'returns validation errors' do
        invalid_params = { post: { title: '' } }

        post '/api/v1/posts', params: invalid_params, headers: auth_headers

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)
        expect(json['error']['details']['title']).to be_present
      end
    end

    context 'when database constraints are violated' do
      before do
        # Create a post with the same slug that will be generated
        create(:post, title: 'Test Post', author: user)
      end

      it 'handles unique constraint violations' do
        post '/api/v1/posts', params: valid_params, headers: auth_headers

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json['error']['details']).to be_present
      end
    end
  end

  describe 'PUT /api/v1/posts/:id' do
    let(:post_record) { create(:post, author: user) }
    let(:update_params) { { post: { title: 'Updated Title' } } }

    context 'when user owns the post' do
      it 'updates the post successfully' do
        put "/api/v1/posts/#{post_record.id}",
            params: update_params,
            headers: auth_headers

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['data']['title']).to eq('Updated Title')

        post_record.reload
        expect(post_record.title).to eq('Updated Title')
      end
    end

    context 'when user does not own the post' do
      let(:other_post) { create(:post, author: other_user) }

      it 'returns forbidden' do
        put "/api/v1/posts/#{other_post.id}",
            params: update_params,
            headers: auth_headers

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when post does not exist' do
      it 'returns not found' do
        put '/api/v1/posts/999999',
            params: update_params,
            headers: auth_headers

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  # Helper method for generating JWT tokens in tests
  def jwt_token(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
```

### Feature specs for user workflows

Test complete user journeys:

### Feature spec testing

```ruby
# spec/features/user_registration_spec.rb
RSpec.feature 'User Registration', type: :feature, js: true do
  background do
    visit new_user_registration_path
  end

  scenario 'User successfully registers with valid information' do
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password Confirmation', with: 'password123'

    click_button 'Sign Up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_content('John Doe')
  end

  scenario 'User sees validation errors with invalid information' do
    fill_in 'Email', with: 'invalid-email'
    fill_in 'Password', with: '123'

    click_button 'Sign Up'

    expect(page).to have_content('Email is invalid')
    expect(page).to have_content('Password is too short')
    expect(page).to have_current_path(new_user_registration_path)
  end

  scenario 'User cannot register with existing email' do
    create(:user, email: 'john@example.com')

    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password Confirmation', with: 'password123'

    click_button 'Sign Up'

    expect(page).to have_content('Email has already been taken')
  end

  scenario 'Password confirmation must match password' do
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password Confirmation', with: 'different'

    click_button 'Sign Up'

    expect(page).to have_content("Password confirmation doesn't match")
  end

  context 'with JavaScript enabled' do
    scenario 'Real-time email validation' do
      fill_in 'Email', with: 'invalid'

      # Blur the email field to trigger validation
      page.execute_script("document.getElementById('user_email').blur()")

      expect(page).to have_css('.field-error', text: 'Please enter a valid email')
    end

    scenario 'Password strength indicator' do
      password_field = find('#user_password')
      password_field.fill_in(with: '123')

      expect(page).to have_css('.password-strength.weak')

      password_field.fill_in(with: 'password123')

      expect(page).to have_css('.password-strength.strong')
    end
  end
end

# spec/features/post_management_spec.rb
RSpec.feature 'Post Management', type: :feature do
  let(:user) { create(:user) }

  background do
    sign_in user
    visit posts_path
  end

  scenario 'User creates a new post' do
    click_link 'New Post'

    fill_in 'Title', with: 'My First Post'
    fill_in 'Content', with: 'This is the content of my first post.'
    check 'Published'

    click_button 'Create Post'

    expect(page).to have_content('Post was successfully created.')
    expect(page).to have_content('My First Post')
    expect(page).to have_content('This is the content')
  end

  scenario 'User edits their own post' do
    post = create(:post, title: 'Original Title', author: user)

    visit edit_post_path(post)

    fill_in 'Title', with: 'Updated Title'
    click_button 'Update Post'

    expect(page).to have_content('Post was successfully updated.')
    expect(page).to have_content('Updated Title')
    expect(page).not_to have_content('Original Title')
  end

  scenario 'User cannot edit other users posts' do
    other_user = create(:user)
    post = create(:post, author: other_user)

    visit edit_post_path(post)

    expect(page).to have_content('You are not authorized to access this page.')
    expect(page).to have_current_path(root_path)
  end

  scenario 'User deletes their post' do
    post = create(:post, title: 'Post to Delete', author: user)

    visit post_path(post)

    accept_confirm do
      click_link 'Delete'
    end

    expect(page).to have_content('Post was successfully deleted.')
    expect(page).not_to have_content('Post to Delete')
  end

  scenario 'User filters posts by status' do
    published_post = create(:post, :published, title: 'Published Post', author: user)
    draft_post = create(:post, :draft, title: 'Draft Post', author: user)

    visit posts_path

    click_link 'Drafts'

    expect(page).to have_content('Draft Post')
    expect(page).not_to have_content('Published Post')
  end
end
```

## End-to-end testing setup

System tests ensure your entire application works together.

### System specs with Capybara

Test critical user journeys with browser automation:

### System testing setup

```ruby
# spec/support/capybara.rb
require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-gpu')
  options.add_argument('--window-size=1920,1080')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :chrome_headless
Capybara.default_max_wait_time = 5

# spec/system/complete_user_journey_spec.rb
RSpec.describe 'Complete User Journey', type: :system, js: true do
  scenario 'User signs up, creates content, and interacts with other users' do
    # Step 1: User registration
    visit root_path
    click_link 'Sign Up'

    fill_in 'First Name', with: 'Alice'
    fill_in 'Last Name', with: 'Johnson'
    fill_in 'Email', with: 'alice@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password Confirmation', with: 'password123'

    click_button 'Sign Up'

    expect(page).to have_content('Welcome, Alice!')

    # Step 2: Create first post
    click_link 'New Post'

    fill_in 'Title', with: 'My Journey with Rails'
    fill_in_rich_text_area 'Content', with: 'This is my first post about learning Rails...'
    check 'Published'

    click_button 'Create Post'

    expect(page).to have_content('Post was successfully created')

    # Step 3: Add tags
    within '.tags-section' do
      fill_in 'Add tag', with: 'rails'
      press_enter

      fill_in 'Add tag', with: 'learning'
      press_enter
    end

    expect(page).to have_css('.tag', text: 'rails')
    expect(page).to have_css('.tag', text: 'learning')

    # Step 4: Upload featured image
    within '.featured-image-section' do
      attach_file 'Featured Image', Rails.root.join('spec/fixtures/sample_image.jpg')
      click_button 'Upload'
    end

    expect(page).to have_css('img.featured-image')

    # Step 5: View the published post
    click_link 'View Post'

    expect(page).to have_content('My Journey with Rails')
    expect(page).to have_css('img.featured-image')
    expect(page).to have_css('.tag', text: 'rails')

    # Step 6: Interact with existing content
    other_post = create(:post, :published, title: 'Welcome to Rails')
    visit post_path(other_post)

    # Leave a comment
    within '.comments-section' do
      fill_in 'Comment', with: 'Great post! Very helpful for beginners.'
      click_button 'Add Comment'
    end

    expect(page).to have_content('Great post! Very helpful')
    expect(page).to have_content('Alice Johnson')

    # Like the post
    find('.like-button').click

    expect(page).to have_css('.like-button.liked')
    expect(page).to have_content('1 like')

    # Step 7: Check notification system
    visit notifications_path

    expect(page).to have_content('Your comment was posted')

    # Step 8: Update profile
    click_link 'Profile'

    fill_in 'Bio', with: 'Rails enthusiast and blogger'
    attach_file 'Avatar', Rails.root.join('spec/fixtures/avatar.jpg')
    click_button 'Update Profile'

    expect(page).to have_content('Profile updated successfully')

    # Step 9: Search functionality
    within '.search-form' do
      fill_in 'Search', with: 'rails'
      click_button 'Search'
    end

    expect(page).to have_content('My Journey with Rails')
    expect(page).to have_content('Welcome to Rails')

    # Step 10: User settings
    click_link 'Settings'

    check 'Email notifications'
    select 'Weekly', from: 'Digest frequency'
    click_button 'Save Settings'

    expect(page).to have_content('Settings saved successfully')
  end

  private

  def fill_in_rich_text_area(locator, with:)
    # Handle rich text editor (assuming Trix or similar)
    find("trix-editor[input='#{locator.downcase.gsub(' ', '_')}']").click.set(with)
  end

  def press_enter
    page.driver.browser.action.send_keys(:return).perform
  end
end
```

> **⚠️ Warning:** System tests are slow and can be flaky. Use them sparingly for critical user journeys, and prefer faster integration tests for most scenarios.

## Test-driven development workflow

TDD helps you write better code and catch bugs early.

### Red-Green-Refactor cycle

Follow the classic TDD cycle:

### TDD workflow example

```ruby
# Step 1: RED - Write a failing test
# spec/models/post_spec.rb
RSpec.describe Post do
  describe '#reading_time' do
    it 'calculates reading time based on word count' do
      post = build(:post, content: 'word ' * 200) # 200 words
      expect(post.reading_time).to eq(1) # 1 minute
    end
  end
end

# Run the test - it should fail
# $ rspec spec/models/post_spec.rb:XX
# NoMethodError: undefined method `reading_time' for #<Post>

# Step 2: GREEN - Write the minimal code to make it pass
# app/models/post.rb
class Post < ApplicationRecord
  def reading_time
    return 0 if content.blank?

    word_count = content.split.size
    (word_count / 200.0).ceil
  end
end

# Run the test again - it should pass
# $ rspec spec/models/post_spec.rb:XX
# 1 example, 0 failures

# Step 3: REFACTOR - Improve the code
# Add more comprehensive tests first
RSpec.describe Post do
  describe '#reading_time' do
    it 'returns 0 for posts without content' do
      post = build(:post, content: nil)
      expect(post.reading_time).to eq(0)
    end

    it 'returns 1 for posts with few words' do
      post = build(:post, content: 'short post')
      expect(post.reading_time).to eq(1)
    end

    it 'calculates reading time for longer posts' do
      post = build(:post, content: 'word ' * 400) # 400 words
      expect(post.reading_time).to eq(2) # 2 minutes
    end

    it 'handles posts with HTML content' do
      post = build(:post, content: '<p>' + ('word ' * 200) + '</p>')
      expect(post.reading_time).to eq(1)
    end
  end
end

# Refactor the implementation
class Post < ApplicationRecord
  AVERAGE_READING_SPEED = 200 # words per minute

  def reading_time
    return 0 if content.blank?

    # Strip HTML tags for accurate word count
    plain_text = ActionView::Base.full_sanitizer.sanitize(content)
    word_count = plain_text.split.size

    # Always return at least 1 minute for any content
    [1, (word_count / AVERAGE_READING_SPEED.to_f).ceil].max
  end
end
```

### Testing controllers with TDD

Apply TDD to controller actions:

# RED: Write failing controller test
# spec/controllers/posts_controller_spec.rb
RSpec.describe PostsController do
  describe 'POST #create' do
    context 'when user is authenticated' do
      let(:user) { create(:user) }
      before { sign_in user }

      context 'with valid parameters' do
        let(:valid_params) do
          { post: { title: 'Test Post', content: 'Test content' } }
        end

        it 'creates a new post' do
          expect {
            post :create, params: valid_params
          }.to change(Post, :count).by(1)
        end

        it 'assigns the post to the current user' do
          post :create, params: valid_params
          expect(assigns(:post).author).to eq(user)
        end

        it 'redirects to the post' do
          post :create, params: valid_params
          expect(response).to redirect_to(assigns(:post))
        end

        it 'sets a success flash message' do
          post :create, params: valid_params
          expect(flash[:notice]).to eq('Post was successfully created.')
        end
      end

      context 'with invalid parameters' do
        let(:invalid_params) do
          { post: { title: '', content: '' } }
        end

        it 'does not create a post' do
          expect {
            post :create, params: invalid_params
          }.not_to change(Post, :count)
        end

        it 'renders the new template' do
          post :create, params: invalid_params
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login' do
        post :create, params: { post: { title: 'Test' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

# GREEN: Implement the controller action
class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end

# REFACTOR: Add more comprehensive error handling
class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      flash.now[:alert] = 'Please correct the errors below.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :published)
  end

  def handle_invalid_record(exception)
    @post = exception.record
    flash.now[:alert] = 'Unable to save post. Please try again.'
    render :new, status: :unprocessable_entity
  end
end

## CI/CD integration

Automate your testing to catch issues early.

### GitHub Actions workflow

Set up continuous testing:

### Continuous integration setup

```yaml
# .github/workflows/test.yml
name: Rails Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest

    services:
      postgres:
        image: postgres:14
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 5432:5432

      redis:
        image: redis:7
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 6379:6379

    steps:
    - uses: actions/checkout@v3

    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.2.0
        bundler-cache: true

    - name: Set up Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'

    - name: Install dependencies
      run: |
        npm install
        sudo apt-get update
        sudo apt-get install -y google-chrome-stable

    - name: Set up database
      env:
        RAILS_ENV: test
        DATABASE_URL: postgres://postgres:postgres@localhost:5432/test
      run: |
        bundle exec rails db:create
        bundle exec rails db:schema:load

    - name: Run linting
      run: |
        bundle exec standardrb
        npm run lint

    - name: Run unit and integration tests
      env:
        RAILS_ENV: test
        DATABASE_URL: postgres://postgres:postgres@localhost:5432/test
        REDIS_URL: redis://localhost:6379/0
      run: |
        bundle exec rspec spec --exclude-pattern="spec/system/**/*_spec.rb"

    - name: Run system tests
      env:
        RAILS_ENV: test
        DATABASE_URL: postgres://postgres:postgres@localhost:5432/test
        REDIS_URL: redis://localhost:6379/0
      run: |
        bundle exec rspec spec/system

    - name: Upload coverage reports
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage/coverage.xml
        fail_ci_if_error: true

    - name: Upload screenshots (if system tests fail)
      uses: actions/upload-artifact@v3
      if: failure()
      with:
        name: screenshots
        path: tmp/screenshots
```

### Test optimization strategies

Make your tests faster and more reliable:

### Test coverage reporting

```ruby
# spec/support/test_performance.rb
RSpec.configure do |config|
  # Use database transactions for speed
  config.use_transactional_fixtures = true

  # Clean up between test runs
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)

    # Preload Rails environment
    Rails.application.eager_load!
  end

  # Optimize factory usage
  config.before(:all) do
    # Create shared test data that doesn't change
    @default_user = create(:user, email: 'test@example.com')
  end

  # Profile slow tests
  config.before(:each) do |example|
    @start_time = Time.current
  end

  config.after(:each) do |example|
    duration = Time.current - @start_time
    if duration > 1.second
      puts "SLOW TEST: #{example.full_description} took #{duration.round(2)}s"
    end
  end

  # Optimize system tests
  config.before(:each, type: :system) do
    # Use faster driver for non-JS tests
    driven_by :rack_test unless example.metadata[:js]
  end

  # Parallel test execution
  if ENV['PARALLEL_WORKERS']
    config.before(:suite) do
      # Set up separate test databases for parallel execution
      test_number = ENV['TEST_ENV_NUMBER']
      ENV['DATABASE_URL'] = "postgres://postgres:postgres@localhost:5432/test#{test_number}"
    end
  end
end

# Gemfile - for parallel testing
group :test do
  gem 'parallel_tests'
end

# Run tests in parallel
# bundle exec parallel_rspec spec/
```

### Performance testing

```ruby
# Gemfile - for performance monitoring
group :test do
  gem 'benchmark-ips'
  gem 'memory_profiler'
end

# spec/performance/model_performance_spec.rb
RSpec.describe 'Model Performance' do
  it 'processes large datasets efficiently' do
    expect {
      1000.times { User.create!(email: Faker::Internet.email) }
    }.to perform_under(5.seconds)
  end

  it 'has acceptable memory usage' do
    report = MemoryProfiler.report do
      100.times { Post.includes(:author).limit(10).load }
    end

    expect(report.total_allocated_memsize).to be < 10.megabytes
  end
end
```

## Ready to build bulletproof Rails apps?

A comprehensive testing strategy isn't just about catching bugs – it's about building confidence in your code and enabling fast, fearless development. When you have good tests, you can refactor with confidence, add features without breaking existing functionality, and deploy with peace of mind.

The key is to start simple and build your testing muscle over time. Don't try to achieve 100% coverage on day one. Focus on testing the most critical parts of your application first, then expand your coverage as you grow.


## Next Steps

**Start building your testing strategy:**

1. Set up RSpec with the essential gems and configuration
2. Write unit tests for your most critical models and services
3. Add integration tests for your key API endpoints or user workflows
4. Implement CI/CD to run tests automatically

**Need help building a comprehensive testing strategy?**

At JetThoughts, we've helped teams implement testing strategies that scale from startup to enterprise. We know how to balance thorough testing with development speed.

Our testing and quality assurance services include:
- Testing strategy design and implementation
- Test automation and CI/CD setup
- Legacy code testing and refactoring
- Team training on TDD and testing best practices
- Code review and quality assessment

Ready to build confidence in your Rails application? [Contact us for a testing strategy consultation](https://jetthoughts.com/contact/) and let's discuss how we can help you ship better software faster.

