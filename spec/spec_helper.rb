require 'rubygems'
require 'bundler/setup'

require 'everblue'
require 'rspec'

require 'capybara/dsl'
require 'capybara-webkit'

require 'pry'

TEST_DRIVER = :webkit

Everblue.root = File.expand_path('suite1', File.dirname(__FILE__))

Capybara.app = Everblue::Application
Capybara.default_driver = TEST_DRIVER

module EverblueMatchers
  class PassSpec # :nodoc:
    def matches?(actual)
      @actual = actual
      @runner = Everblue::Runner.new(StringIO.new).spec_runner(@actual)
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
    PassSpec.new
  end
end

RSpec.configure do |config|
  config.include EverblueMatchers
  config.before do
    Capybara.reset_sessions!
    Everblue.use_defaults!
    Everblue.root = File.expand_path('suite1', File.dirname(__FILE__))
    Everblue.driver = TEST_DRIVER
  end
end
