require 'coffee_script'

module Everblue
  class Server
    attr_reader :suite

    def serve
      server.boot
      Launchy.open(server.url(Everblue.mounted_at.to_s + '/'))
      sleep
    end

  protected

    def server
      @server ||= Capybara::Server.new(Everblue.application)
    end
  end
end

