---
dev_to_id: 1170570
title: "How to use Ruby on Rails Concerns"
description: "A Rails concern is a module that extends the ActiveSupport::Concern module.  You can use Сoncerns to..."
created_at: "2022-08-18T14:43:37Z"
edited_at: "2024-05-10T19:44:44Z"
sync_date: "2024-05-27T16:09:29Z"
draft: false
tags: ["ruby", "webdev", "rails", "bestpractices"]
canonical_url: "https://jtway.co/how-to-use-ruby-on-rails-concerns-919139a74e64"
slug: "how-use-ruby-on-rails-concerns-webdev"
---

A Rails concern is a module that extends the `ActiveSupport::Concern` module.

You can use Сoncerns to store common code for several classes there, or for refactoring to separate semantically similar code in separate modules.

A concern provides two blocks:
```ruby
module SampleConcern
  extend ActiveSupport::Concern
  
  included do
    ...
  end
  
  class_methods do
    ...
  end
end
```

## included:
The code inside the included block is evaluated in the context of the including class.

## class_methods:
Here you can implement methods that will become methods of the class to which the container is included.

Let’s look at an example:

## Concern:

```ruby
module AuthenticationConcern
  extend ActiveSupport::Concern
  
  included do
    before_action :authenticate
  end
  
  private
    def authenticate
      if authenticated_user = User.find_by(id: cookies.encrypted[:user_id])
        current_user = authenticated_user
      else
        redirect_to new_session_url
      end
    end
end
```

## Controller:
```ruby
class ApiBaseController < ActionController::Base
  include AuthenticationConcern
  ...
end
```
By using Сoncerns, we have moved the code responsible for user authorization to a separate module.

## Testing
Concerns are also convenient in that they can be tested in isolation instead of covering all classes where the concern is included with tests.
```ruby
require 'rails_helper'
class FakeController < ApplicationController
  include AuthenticationConcern
  
  def new; end
end
RSpec.describe FakeController, type: :controller do    
  context '#new' do
    context 'valid user'  do
      get :new, headers: {token: 'valid_token'}     
      it { expect(response).to have_http_status(:success) }
    end
    
    context 'invalid user' do 
      get :new, headers: {token: 'invalid_token'}
      it { expect(response).to redirect_to(new_session_url) }
    end
  end
end
```