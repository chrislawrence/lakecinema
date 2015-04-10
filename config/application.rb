require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(:default, Rails.env)

module Lakecinema
  class Application < Rails::Application
    config.generators.test_framework = false
    config.i18n.enforce_available_locales = false
    config.time_zone = 'Sydney'
    config.assets.paths << Rails.root.join("app", "assets", "fonts") 
    
    config.admin_emails = ['c@chrislawrence.co', 'boblakec@hotmail.com']
    config.active_record.raise_in_transactional_callbacks = true
  end
end
