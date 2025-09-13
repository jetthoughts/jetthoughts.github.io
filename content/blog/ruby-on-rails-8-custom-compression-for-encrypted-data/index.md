---
remote_url: https://dev.to/jetthoughts/ruby-on-rails-8-custom-compression-for-encrypted-data-48n5
source: dev_to
remote_id: 2086252
dev_to_id: 2086252
dev_to_url: https://dev.to/jetthoughts/ruby-on-rails-8-custom-compression-for-encrypted-data-48n5
title: 'Ruby on Rails 8: Custom Compression for Encrypted Data'
description: In Ruby on Rails 8, ActiveRecord’s encryption features are more flexible than ever. You can now set a...
created_at: '2024-11-08T08:48:36Z'
edited_at: '2024-11-25T15:42:09Z'
draft: false
tags:
- ruby
- rails
- webdev
- tutorial
canonical_url: https://jetthoughts.com/blog/ruby-on-rails-8-custom-compression-for-encrypted-data/
cover_image: https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/content/blog/ruby-on-rails-8-custom-compression-for-encrypted-data/cover.png
metatags:
  image: cover.png
slug: ruby-on-rails-8-custom-compression-for-encrypted-data
---
In Ruby on Rails 8, ActiveRecord’s encryption features are more flexible than ever. You can now set a custom compression algorithm for encrypted attributes. This update lets you manage data size while keeping it secure. Whether you're storing large encrypted text or using custom compression algorithms, this feature can streamline storage and retrieval.

## How to Use Custom Compression with ActiveRecord Encryption

The `:compressor` option lets you define your compression module. Here’s how to use it with a custom algorithm, such as `Zstd`:

1. **Create Your Compressor Module**  
   Define a module with `deflate` and `inflate` methods for compressing and decompressing data. Here’s an example using `Zstd`:

   ```ruby
   module ZstdCompressor
     def self.deflate(data)
       Zstd.compress(data)
     end

     def self.inflate(data)
       Zstd.decompress(data)
     end
   end
   ```

2. **Apply Custom Compression to Encrypted Attributes**  
   Use the `:compressor` option when encrypting an attribute. For instance, to encrypt and compress the `name` attribute with `ZstdCompressor`, do this:

   ```ruby
   class User
     encrypts :name, compressor: ZstdCompressor
   end
   ```

   This setup will compress data with `Zstd` before encryption, optimizing storage for encrypted text.

## How to Disable Compression

If you prefer not to compress an encrypted attribute, simply set `compress: false`:

```ruby
class User
  encrypts :name, compress: false
end
```

This configuration turns off compression entirely, allowing the data to be stored as-is.

#### Practical Use Cases

1. **Optimizing Storage for Encrypted Data**
   If your app stores large amounts of encrypted text, a custom compressor can save space, especially with highly compressible data. Rails now lets you choose the best algorithm for your needs.

2. **Adapting for Performance**
   Some compression algorithms are faster than others. Using `:compressor`, you can optimize performance based on your app’s requirements. For example, Zstd offers high compression ratios with quick decompression, which is ideal for frequently accessed encrypted data.

3. **Customizing Compression for Specific Fields**
   Not all fields need compression. Rails gives you granular control to apply compression where needed and skip it where it’s not, balancing storage and speed.

#### Why This Matters

The ability to customize compression lets you balance security, performance, and storage. Rails 8’s `:compressor` option makes encrypted data more efficient and tailored to your specific needs, making storage optimization straightforward and flexible.

Use Rails 8’s encryption improvements to keep your data safe and storage efficient!
