# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsProject66
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.i18n.available_locales = %i[ru en]
    config.i18n.default_locale = :ru

    routes.default_url_options = { host: ENV['BASE_URL'] }

    config.action_mailer.delivery_method = :mailtrap
    config.action_mailer.mailtrap_settings = {
      api_key: ENV.fetch('MAILTRAP_API_KEY')
    }
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
