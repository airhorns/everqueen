module Everblue
  class Cli
    def self.execute(argv)
      new.execute(argv)
    end

    def execute(argv)
      command = argv.shift
      Everblue.root = File.expand_path(argv.shift || '.', Dir.pwd)

      # detect Rails apps
      if File.exist?(File.join(Everblue.root, 'config/environment.rb'))
        require File.join(Everblue.root, 'config/environment.rb')
        require 'everblue/rails' if defined?(Rails)
      end

      case command
      when "serve"
        Everblue::Server.new.serve
        return true
      when "run"
        return Everblue::Runner.new.run
      else
        puts "no such command '#{command}'"
        return false
      end
    end
  end
end
