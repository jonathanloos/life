require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Life
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_job.queue_adapter = :sidekiq

    # Set Redis as the back-end for the cache.
    config.cache_store = :redis_cache_store, {
      url: ENV.fetch("REDIS_URL"),
      namespace: "cache"
    }

    # Set Sidekiq as the back-end for Active Job.
    config.active_job.queue_adapter = :sidekiq

    # Separate Action Cable into its own process.
    config.action_cable.url = ENV.fetch("ACTION_CABLE_FRONTEND_URL") { "ws://localhost:28080" }

    # Action Cable will only allow connections from these domains.
    origins = ENV.fetch("ACTION_CABLE_ALLOWED_REQUEST_ORIGINS") { "http:\/\/localhost*" }.split(",")
    origins.map! { |url| /#{url}/ }
    config.action_cable.allowed_request_origins = origins
  end
end
