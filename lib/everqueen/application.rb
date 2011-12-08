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
      erb :run
    end
  end

  AssetsEnvironment = Sprockets::Environment.new
  assets_path = File.expand_path(File.join(File.dirname(__FILE__), 'assets'))
  AssetsEnvironment.append_path assets_path
  qunit_assets_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'qunit', 'qunit'))
  AssetsEnvironment.append_path qunit_assets_path

  Application = Rack::Builder.app do
    map '/assets' do
      run AssetsEnvironment
    end

    map '/' do
      run TestApplication
    end
  end
end
