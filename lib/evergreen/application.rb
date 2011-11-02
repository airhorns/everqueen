module Evergreen
  class << self
    attr_writer :application

    def application
      @application ||= build_application
    end

    def build_application
      Rack::Builder.new do
        instance_eval(&Evergreen.extensions) if Evergreen.extensions

        map "/" do
          app = Class.new(Sinatra::Base).tap do |app|
            app.reset!
            app.class_eval do
              set :static, false
              set :root, File.expand_path('.', File.dirname(__FILE__))

              helpers do
                def url(path)
                  Evergreen.mounted_at.to_s + path.to_s
                end

                def render_spec(spec)
                  spec.read if spec
                rescue StandardError => error
                  erb :_spec_error, :locals => { :error => error }
                end
              end

              get '/' do
                @suite = Evergreen::Suite.new
                erb :list
              end

              get '/run/all' do
                @suite = Evergreen::Suite.new
                @js_spec_helper = @suite.get_spec('spec_helper.js')
                @coffee_spec_helper = @suite.get_spec('spec_helper.coffee')
                erb :run
              end

              get '/run/*' do |name|
                @suite = Evergreen::Suite.new
                @spec = @suite.get_spec(name)
                @js_spec_helper = @suite.get_spec('spec_helper.js')
                @coffee_spec_helper = @suite.get_spec('spec_helper.coffee')
                erb :run
              end

              get "/jasmine/*" do |path|
                send_file File.expand_path(File.join('../jasmine/lib', path), File.dirname(__FILE__))
              end

              get "/resources/*" do |path|
                send_file File.expand_path(File.join('resources', path), File.dirname(__FILE__))
              end

              get '/*' do |path|
                send_file File.join(Evergreen.root, Evergreen.public_dir, path)
              end
            end
          end
          run app
        end
      end.tap do |app|
        def app.inspect; '<Evergreen Application>'; end
      end
    end
  end
end
