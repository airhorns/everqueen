require 'everqueen'
require 'rails'

module Everqueen
  if defined?(Rails::Engine)
    class Railtie < Rails::Engine
      initializer 'everqueen.config' do
        Everqueen.application = Rails.application
        Everqueen.root = Rails.root
        Everqueen.mounted_at = "/everqueen"
        if Rails.application.assets
          Rails.application.assets.paths.each do |path|
            Everqeen::AssetsEnvironment.append_path path
          end
        end
      end
    end
  end
end
