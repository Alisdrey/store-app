# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :store_api,
  ecto_repos: [StoreApi.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :store_api, StoreApiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: StoreApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: StoreApi.PubSub,
  live_view: [signing_salt: "Qwmn+6DJ"]

config :store_api, StoreApi.Mailer, adapter: Swoosh.Adapters.Local

config :store_api, StoreApiWeb.Auth.Guardian,
  issuer: "store_api",
  secret_key: System.fetch_env!("SECRET_KEY_BASE")


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
