# frozen_string_literal: true

source "https://rubygems.org"

repo_name = "RayTracer"
git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

group :test do
  if RUBY_PLATFORM =~ /(win32|w32)/
    gem "win32console", '1.3.0'
  end
  gem "minitest"
  gem 'minitest-reporters', '>= 0.5.0'
  gem 'cucumber-rails'
  gem 'require_all'
end
