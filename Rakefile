# frozen_string_literal: true

require "rake/testtask"


Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.pattern = "test/**/*_test.rb"
end


namespace :test do

  Rake::TestTask.new(:all) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.pattern = "test/**/*_test.rb"
  end

  Rake::TestTask.new(:critical) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.pattern = "test/system/*_test.rb"
  end
end

task default: "test:all"
