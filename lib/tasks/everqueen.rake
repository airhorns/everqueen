# Rails 3.0/3.1 Rake tasks
namespace :test do
  desc "Run JavaScript specs via Everqueen"
  task :javascripts => :environment do
    result = Everqueen::Runner.new.run
    Kernel.exit(1) unless result
  end
end
