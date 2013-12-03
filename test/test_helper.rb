require "coveralls"
Coveralls.wear!('rails')
# Disabled because Coveralls & Code Climate don't seem to work together, I prefer Coveralls
# require "codeclimate-test-reporter"
# CodeClimate::TestReporter.start
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/spec"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
require "minitest/rails/capybara"

# Uncomment for awesome colorful output
require "minitest/pride"

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  include FactoryGirl::Syntax::Methods
 
end

class ActionController::TestCase
  include FactoryGirl::Syntax::Methods
  include Devise::TestHelpers
  before do
    @request.host = ENV['SITE_URL']
  end
end

class ActionMailer::TestCase
  include FactoryGirl::Syntax::Methods
end