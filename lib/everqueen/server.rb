require 'coffee_script'

module Everqueen
  class Server
    attr_reader :suite

    def serve
      server.boot
      Launchy.open(server.url(Everqueen.mounted_at.to_s + '/'))
      sleep
    end

  protected

    def server
      @server ||= Capybara::Server.new(Everqueen.application)
    end
  end
end
