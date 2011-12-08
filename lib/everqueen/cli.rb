module Everqueen
  class Cli
    def self.execute(argv)
      new.execute(argv)
    end

    def execute(argv)
      command = argv.shift
      Everqueen.root = File.expand_path(argv.shift || '.', Dir.pwd)

      # detect Rails apps
      if File.exist?(File.join(Everqueen.root, 'config/environment.rb'))
        require File.join(Everqueen.root, 'config/environment.rb')
        require 'everqueen/rails' if defined?(Rails)
      end

      case command
      when "serve"
        Everqueen::Server.new.serve
        return true
      when "run"
        return Everqueen::Runner.new.run
      else
        puts "no such command '#{command}'"
        return false
      end
    end
  end
end
