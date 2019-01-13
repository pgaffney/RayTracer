#!/usr/bin/env ruby

# test/test_helper.rb
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

ENV["RAILS_ENV"] = "test"
#require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

# RubyMine
if ENV["RUBYMINE_TESTUNIT_REPORTER"]
  $:.unshift(ENV["RUBYMINE_TESTUNIT_REPORTER"])
  $:.uniq!
end

#require 'test_help' # !!! test_helper script loads 'test/unit'
