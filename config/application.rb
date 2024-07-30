# rubocop:disable all
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Crewcenter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    config.session_store :cookie_store, key: '_crewcenter_session', expire_after: 2.weeks, secure: Rails.env.production?, httponly: true, same_site: :lax

    # SQLite optimizations
    config.after_initialize do
      if ActiveRecord::Base.connection.adapter_name == 'SQLite'
        ActiveRecord::Base.connection.execute('PRAGMA journal_mode=WAL;')
        ActiveRecord::Base.connection.execute('PRAGMA cache_size=64000;')
      end
    end
  end
end
