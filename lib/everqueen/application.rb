require 'sprockets'

module Everqueen
  class TestApplication < Sinatra::Base

    set :static, false
    set :root, File.expand_path('.', File.dirname(__FILE__))

    helpers do
      def url(path)
        Everqueen.mounted_at.to_s + path.to_s
      end
    end

    get '/' do
      @suite = Everqueen::Suite.new
      erb :list
    end

    get '/run/all' do
      @suite = Everqueen::Suite.new
      erb :run
    end

    get '/run/*' do |name|
      @suite = Everqueen::Suite.new
      @test = @suite.get_test(name)
      @inject_script = params[:inject_script] if params[:inject_script].present?
      erb :run
    end
  end

  @@assets_environment = nil

  def self.assets_environment
    @@assets_environment
  end

  def self.assets_environment=(env)
    @@assets_environment = env
  end

  def self.apply_default_asset_paths!
    assets_path = File.expand_path(File.join(File.dirname(__FILE__), 'assets'))
    qunit_assets_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'qunit', 'qunit'))
    Everqueen.assets_environment.append_path assets_path
    Everqueen.assets_environment.append_path qunit_assets_path
    true
  end

  unless defined?(Rails)
    Everqueen.assets_environment = Sprockets::Environment.new
    Everqueen.apply_default_asset_paths!
  end

  Application = Rack::Builder.app do
    map '/assets' do
      run lambda { |env| Everqueen.assets_environment.call(env) }
    end

    map '/' do
      run TestApplication
    end
  end
end
