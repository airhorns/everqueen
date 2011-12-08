require 'everqueen'
require 'rails'

module Everqueen
  if defined?(Rails::Engine)
    class Railtie < Rails::Engine
      initializer 'everqueen.config' do
        Everqueen.application = Rails.application
        Everqueen.root = Rails.root
        Everqueen.mounted_at = "/everqueen"
      end
    end
  end
end
