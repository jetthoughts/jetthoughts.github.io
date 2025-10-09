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

desc "Build the site (Hugo)"
task :build do
  sh "./bin/hugo-build"
end

desc "Run server (Hugo)"
task :dev do
  sh "./bin/hugo-dev"
end

task default: "test:all"
