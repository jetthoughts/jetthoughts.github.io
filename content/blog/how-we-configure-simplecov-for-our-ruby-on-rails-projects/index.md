---
dev_to_id: 1673284
title: "How we configure Simplecov for our Ruby on Rails projects."
description: "Here’s a step-by-step guide to setting up simplecov with explanations of what each part of the code..."
created_at: "2023-11-21T07:40:02Z"
edited_at: "2024-11-01T19:07:02Z"
draft: false
tags: ["ruby", "rails", "testing", "tutorial"]
canonical_url: "https://jetthoughts.com/blog/how-we-configure-simplecov-for-our-ruby-on-rails-projects/"
cover_image: ""
slug: "how-we-configure-simplecov-for-our-ruby-on-rails-projects"
---

Here’s a step-by-step guide to setting up simplecov with explanations of what each part of the code does:

## Step 1: Install the simplecov gem

Add the following line to your Gemfile:

`gem ‘simplecov’`
Then run bundle install to install the gem.

## Step 2: Create a test helper file
Create a file called spec_helper.rb or test_helper.rb in your project’s test directory if it does not exist.

## Step 3: Require the simplecov gem and start coverage
In the `spec_helper.rb` or `test_helper.rb` file, add the following code to require the simplecov gem and start coverage:
```ruby
require ‘simplecov’
SimpleCov.start 'rails' do
# Configuration options go here
end
```
The ‘rails’ argument specifies the Rails formatter, which is used to generate coverage reports specific to Rails projects.

## Step 4: Configure coverage filters
Inside the `SimpleCov.start` block, you can configure coverage filters to exclude certain files or directories from the coverage report. The add_filter method is used to specify these filters. In the given configuration, the following filters are applied:
```ruby
add_filter %w[
  app/views 
  lib/rails 
  lib/templates
  bin 
  coverage 
  log 
  test 
  vendor 
  node_modules 
  db 
  doc   
  public 
  storage 
  tmp
]
```
This filter excludes files and directories commonly found in Rails projects that typically don’t contain application code.

## Step 5: Add non default groups like Services, Views and View Objects
You can also group files in the coverage report to provide a better overview of code coverage. In the given configuration, the following groups are specified:
```ruby
add_group(‘Carriers’, ‘app/carriers’)
add_group('Scripts', 'app/scripts')
add_group("Views", "app/views")
```
These lines create two groups: “Carriers”, “Scripts” and “Views”.

## Step 6: Enable coverage for specific features
The given configuration enables coverage for branches and coverage for eval methods by Kernel#eval:
```ruby
enable_coverage(:branch)
enable_coverage_for_eval
```
Enabling coverage for branches allows simplecov to track branch coverage in your code. Enabling coverage for eval methods ensures that code executed via eval is also included in the coverage report.

## Step 7: Support distributed parallel executions
If you’re running tests in parallel (e.g., using a tool like CircleCI or parallel test runners), you can set a custom command name for each job to differentiate them in the coverage report:
```ruby
parallel_number = [
  ENV['CIRCLE_NODE_INDEX'] || ENV['CI_INDEX'],
  ENV['TEST_ENV_NUMBER'] || ENV['JOB_NUMBER']
].compact.join('_')

if parallel_number.present?
  SimpleCov.command_name "Job #{parallel_number}"
end
```
This code retrieves the environment variables used by popular parallel testing tools and sets a unique command name for each job.

## Step 8: Enable additional formatter (optional)
If you want to use the Cobertura formatter to generate Cobertura-compatible coverage reports, you can enable it by requiring the simplecov-cobertura gem and setting the formatter:
```ruby
if ENV[‘COBERTURA_ENABLED’]
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end
```
This code checks if the COBERTURA_ENABLED environment variable is present and, if so, requires the simplecov-cobertura gem and sets the Cobertura formatter.

That’s it! With these steps, you’ve successfully configured simplecov with the provided configuration. When you run your tests, simplecov will generate coverage reports based on this configuration.

You can find the complete configuration code [here](https://github.com/jetthoughts/jt_tools/blob/master/lib/install/.simplecov). Happy Coding!