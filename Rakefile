#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
require 'bundler'
Bundler.setup

require 'rake'
require 'rspec'
require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'rubygems/package_task'
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end
