# test/test_helper.rb
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

# RubyMine
if ENV["RUBYMINE_TESTUNIT_REPORTER"]
  $:.unshift(ENV["RUBYMINE_TESTUNIT_REPORTER"])
  $:.uniq!
end

require 'test_help' # !!! test_helper script loads 'test/unit'
