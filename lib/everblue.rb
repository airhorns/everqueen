require 'rubygems'
require 'sinatra/base'
require 'capybara'
require 'launchy'
require 'everblue/version'
require 'everblue/application'
require 'json'

module Everblue
  autoload :Cli, 'everblue/cli'
  autoload :Server, 'everblue/server'
  autoload :Runner, 'everblue/runner'
  autoload :Suite, 'everblue/suite'
  autoload :Test, 'everblue/test'
  autoload :Template, 'everblue/template'

  class << self
    attr_accessor :driver, :public_dir, :template_dir, :test_dir, :root, :mounted_at, :application

    def configure
      yield self
    end

    def use_defaults!
      configure do |config|
        config.application = Everblue::Application
        config.driver = :selenium
        config.public_dir = 'public'
        config.test_dir = 'test/javascripts'
        config.template_dir = 'test/javascripts/templates'
        config.mounted_at = ""
      end
    end
  end
end

Everblue.use_defaults!
