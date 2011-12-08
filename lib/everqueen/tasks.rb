require 'everqueen'

# Rails 2.3 Rake tasks
namespace :spec do
  desc "Run JavaScript specs via Everqueen"
  task :javascripts => :environment do
    result = Everqueen::Runner.new.run
    Kernel.exit(1) unless result
  end
end
