#!/usr/bin/env ruby

#require 'require_all'
#require_all "lib"

require "tuple"
require "point"
require "vector"
require "color"
require "projectile"
require "environment"
require "canvas"
require "matrix"

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
