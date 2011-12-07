# Rails 3.0/3.1 Rake tasks
namespace :test do
  desc "Run JavaScript tests via Everblue"
  task :javascripts => :environment do
    result = Everblue::Runner.new.run
    Kernel.exit(1) unless result
  end
end
