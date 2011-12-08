require 'rubygems'
require 'bundler/setup'

require 'everqueen'
require 'rspec'

require 'capybara/dsl'
require 'capybara-webkit'

require 'pry'

TEST_DRIVER = :webkit

Everqueen.root = File.expand_path('suite1', File.dirname(__FILE__))

Capybara.app = Everqueen::Application
Capybara.default_driver = TEST_DRIVER

module EverqueenMatchers
  class PassTest # :nodoc:
    def matches?(actual)
      @actual = actual
      @runner = Everqueen::Runner.new(StringIO.new).test_runner(@actual)
      @runner.passed?
    end

    def failure_message
      "expected #{@actual.name} to pass, but it failed with:\n\n#{@runner.failure_messages}"
    end

    def negative_failure_message
      "expected #{@actual.name} not to pass, but it did"
    end
  end

  def pass
    PassTest.new
  end
end

RSpec.configure do |config|
  config.include EverqueenMatchers
  config.before do
    Capybara.reset_sessions!
    Everqueen.use_defaults!
    Everqueen.root = File.expand_path('suite1', File.dirname(__FILE__))
    Everqueen.driver = TEST_DRIVER
  end
end
