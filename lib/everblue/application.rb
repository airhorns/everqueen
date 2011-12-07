module Everblue
  class Application < Sinatra::Base
    set :static, false
    set :root, File.expand_path('.', File.dirname(__FILE__))

    helpers do
      def url(path)
        Everblue.mounted_at.to_s + path.to_s
      end

      def render_spec(spec)
        spec.read if spec
      rescue StandardError => error
        erb :_spec_error, :locals => { :error => error }
      end
    end

    get '/' do
      @suite = Everblue::Suite.new
      erb :list
    end

    get '/run/all' do
      @suite = Everblue::Suite.new
      @js_spec_helper = @suite.get_spec('spec_helper.js')
      @coffee_spec_helper = @suite.get_spec('spec_helper.coffee')
      erb :run
    end

    get '/run/*' do |name|
      @suite = Everblue::Suite.new
      @spec = @suite.get_spec(name)
      @js_spec_helper = @suite.get_spec('spec_helper.js')
      @coffee_spec_helper = @suite.get_spec('spec_helper.coffee')
      erb :run
    end

    get "/jasmine/*" do |path|
      send_file File.expand_path(File.join('../jasmine/lib/jasmine-core', path), File.dirname(__FILE__))
    end

    get "/resources/*" do |path|
      send_file File.expand_path(File.join('resources', path), File.dirname(__FILE__))
    end

    get '/*' do |path|
      send_file File.join(Everblue.root, Everblue.public_dir, path)
    end
  end
end
