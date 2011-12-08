require 'rubygems'
require 'sinatra/base'
require 'capybara'
require 'launchy'
require 'coffee-script'
require 'everqueen/version'
require 'everqueen/application'
require 'json'

module Everqueen
  autoload :Cli, 'everqueen/cli'
  autoload :Server, 'everqueen/server'
  autoload :Runner, 'everqueen/runner'
  autoload :Suite, 'everqueen/suite'
  autoload :Test, 'everqueen/test'

  class << self
    attr_accessor :driver, :public_dir, :test_dir, :root, :mounted_at, :application

    def configure
      yield self
    end

    def use_defaults!
      configure do |config|
        config.application = Everqueen::Application
        config.driver = :selenium
        config.public_dir = 'public'
        config.test_dir = 'test/javascripts'
        config.mounted_at = ""
      end
    end

    def test_dir=(new_dir)
      update_asset_paths(new_dir, test_dir)
      @test_dir = new_dir
    end

    def public_dir=(new_dir)
      update_asset_paths(new_dir, public_dir)
      @public_dir = new_dir
    end

    def root=(new_root)
      @root = new_root
      update_asset_paths(test_dir, test_dir)
      update_asset_paths(public_dir, public_dir)
      @root
    end

    private

    def update_asset_paths(new_dir, old_dir)
      return if root.nil?
      old_dir = File.expand_path(old_dir, root)
      new_dir = File.expand_path(new_dir, root)
      old_paths = Everqueen::AssetsEnvironment.clear_paths
      old_paths.delete(old_dir)
      old_paths.unshift(new_dir).each do |dir|
        Everqueen::AssetsEnvironment.append_path(dir)
      end
    end
  end
end

Everqueen.use_defaults!
