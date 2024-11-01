---
dev_to_id: 1103639
title: "Generating random strings with Ruby"
description: "When you need to generate a random alphanumeric string of a specified length in ruby you have a..."
created_at: "2022-06-03T06:57:33Z"
edited_at: "2024-11-01T13:35:46Z"
draft: false
tags: ["ruby", "webdev"]
canonical_url: "https://jetthoughts.com/blog/generating-random-strings-with-ruby-webdev/"
cover_image: "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fmedia.dev.to%2Fcdn-cgi%2Fimage%2Fwidth%3D1000%2Cheight%3D420%2Cfit%3Dcover%2Cgravity%3Dauto%2Cformat%3Dauto%2Fhttps%253A%252F%252Fdev-to-uploads.s3.amazonaws.com%252Fuploads%252Farticles%252F7vytirms7om8v9u9sdvo.png"
slug: "generating-random-strings-with-ruby-webdev"
metatags:
  image: cover.png
---
When you need to generate a random alphanumeric string of a specified length in ruby you have a couple of options.

If you are using Ruby version >= 2.5 you can simply go with:

```ruby
SecureRandom.alphanumeric(length)
```

For older versions you can utilize a little numeric convertion hack: `Integer#to_s` method accepts an argument representing the base. 
For example:

```ruby
13.to_s(2)  # => "1101" in binary
13.to_s(16) # => "d" in hex
```


```ruby
def alphanumerical_code(length)
  # 36 is used here as base: we want 10 digits plus 26 letters
  (36 ** (length - 1) + rand(36 ** length - 36 ** (length - 1))).to_s(36) 
end

def digital_code(length)
  (10 ** (length - 1) + rand(10 ** length - 10 ** (length - 1))).to_s(10)
end
```

## More custom generator

In case if you need to build something more specific and have more control, you can create your own generator.
Let's say we need a random alphanumeric string generator, which excludes some of the letters, so the strings are more easily distinguished by customer in printed media.


```ruby
class Generator
  CHARSET = [('0'..'9'), ('a'..'z'), ('A'..'Z')]

  def initialize(length:, exceptions: [])
    @length = length
    @allowed_charset = CHARSET.flat_map(&:to_a) - exceptions
  end

  def perform
    (0...@length)
      .map { @allowed_charset[rand(@allowed_charset.size)] }
      .join
  end
end

generator = Generator.new(
  length: 10, 
  exceptions: ['1', 'I', 'l', '0', 'o', 'O']
)
generator.perform
(1..3).map { better_generator.perform } 
# => ["FXCpz9evUj", "JP3uGhF35i", "rP4wv8Q5rm"]

```
