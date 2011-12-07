module Everblue
  class Application < Sinatra::Base
    set :static, false
    set :root, File.expand_path('.', File.dirname(__FILE__))

    helpers do
      def url(path)
        Everblue.mounted_at.to_s + path.to_s
      end

      def render_test(test)
        test.read if test
      rescue StandardError => error
        erb :_test_error, :locals => { :error => error }
      end
    end

    get '/' do
      @suite = Everblue::Suite.new
      erb :list
    end

    get '/run/all' do
      @suite = Everblue::Suite.new
      @js_test_helper = @suite.get_test('test_helper.js')
      @coffee_test_helper = @suite.get_test('test_helper.coffee')
      erb :run
    end

    get '/run/*' do |name|
      @suite = Everblue::Suite.new
      @test = @suite.get_test(name)
      @js_test_helper = @suite.get_test('test_helper.js')
      @coffee_test_helper = @suite.get_test('test_helper.coffee')
      erb :run
    end

    get "/resources/*" do |path|
      send_file File.expand_path(File.join('resources', path), File.dirname(__FILE__))
    end

    get '/*' do |path|
      send_file File.join(Everblue.root, Everblue.public_dir, path)
    end
  end
end
