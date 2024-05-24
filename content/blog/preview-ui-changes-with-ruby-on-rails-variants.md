---
dev_to_id: 1108673
title: "Preview UI changes with Ruby on Rails variants"
description: "When implementing new design for a live application we usually don’t want our users to see an..."
created_at: "2022-06-08T20:15:39Z"
edited_at: ""
sync_date: "2024-05-24T16:04:34Z"
draft: false
tags: ["rails", "ruby", "webdev"]
canonical_url: "https://jtway.co/preview-ui-changes-with-ruby-on-rails-variants-527c13bf7fd0"
slug: "preview-ui-changes-with-ruby-on-rails-variants"
---
When implementing new design for a live application we usually don’t want our users to see an unfinished implementation, but we might want to give some users the ability to preview it on the live (production or staging) environment, for designers, product owners, our most loyal customers.

Here's one of the simplest ways to do it without introducing complex feature switching mechanisms.

## The Rails way
Fortunately Ruby on Rails got us covered on this one with the help of [view variants](https://guides.rubyonrails.org/layouts_and_rendering.html#the-variants-option). In short, it allows us to define several different view templates for the same controller action, and determine which one should be rendered on the controller level.


Let's say we have a Dashboard#show and want to change the way data is presented. Then we need to create a new view `show.html+redesign.erb`, so we end up with two views for the same action:
```ruby
app/views/dashboard/show.html.erb
app/views/dashboard/show.html+redesign.erb
```

To render dashboard with new design we can explicitly pass the variant name to the action renderer:
```ruby
def show
  render variants: [:redesign]
end
```

But since we want it on demand only and don't want to affect other users, we need a way to switch it on/off. We can do that by requiring users to pass a preview parameter with their request:
```ruby
def show
  render variants: [:redesign] if params[:preview]
end
```

## Make it reusable

Let's extract this into a concern so it'll be easier to reuse for other pages, and also we want to make as little as possible modifications of the exiting code.

Also we can store the preview flag in the session, so that users won't have to pass the `preview` param with each request.
```ruby
module RedesignPreview
  extend ActiveSupport::Concern

  included { before_action :set_redesign_preview }

  class_methods do
    def with_redesign_preview(options = {})
      before_action(options) { set_redesign_variant }
    end
  end

  private

  def set_redesign_variant
    request.variant = :redesign
  end

  def redesign_preview?
    session[:redesign_preview]
  end

  def set_redesign_preview
    session[:redesign_preview] = true if params[:preview].present?
    session.delete(:redesign_preview) if params[:preview_reset].present?
  end
end
```

And then use it in our `DashboardController` enabling redesign only for `#show` action:
```ruby
class DashboardController < ApplicationController
  include RedesignPreview

  with_redesign_preview only: :show, if: :redesign_preview?
end
```

Now to preview redesign users can pass the `preview` parameter and reset back to the usual:
```
http://example.com/dashboard?preview=1 # to enable preview
http://example.com/dashboard?preview_reset=1 # to disable preview
```

## Customize to your needs

Furthermore, we can extract that and give users an ability to control that from their profile settings for example.

```ruby
class RedesignPreviewController < ApplicationController
  def create
    session[:redesign_preview] = true
  end

  def destroy
    session.delete(:redesign_preview)
  end
end
```

Also, we can change our `RedesignPreview` concern a bit to make it more flexible and support different preview variants:
```ruby
module RedesignPreview
  extend ActiveSupport::Concern
  
  included { before_action :set_redesign_preview }
  
  class_methods do
    def with_redesign_preview(options = {})
      variant = options.delete(:variant)
      before_action(options) { set_redesign_variant(variant) }
    end
  end
  
  private
  
  def set_redesign_variant(variant)
    request.variant = :redesign
  end
  ...
end
```
And pass variant as a parameter:
```ruby
with_redesign_preview only: :show, 
                      if: :redesign_preview?, 
                      variant: :alternate_version
```

If you need to add a preview for more than one page, you can create variants for layouts and partials as well, and include the concern into your `ApplicationController`:

```ruby
class ApplicationController < ActionController::Base
  include RedesignPreview

  with_redesign_preview if: :redesign_preview?
end
```