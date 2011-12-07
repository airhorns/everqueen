require 'everblue'
require 'rails'

module Everblue
  if defined?(Rails::Engine)
    class Railtie < Rails::Engine
      initializer 'everblue.config' do
        Everblue.application = Rails.application
        Everblue.root = Rails.root
        Everblue.mounted_at = "/everblue"
      end
    end
  end
end
