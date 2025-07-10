import Config

config :store_api, StoreApi.Repo,
  username: System.get_env("DB_USER"),
  password: System.get_env("DB_PASS"),
  hostname: System.get_env("DB_HOST"),
  database: System.get_env("DB_NAME"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: String.to_integer(System.get_env("DB_POOL_SIZE") || "10")

config :store_api, StoreApiWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4001],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
  watchers: []

config :store_api, StoreApi.Auth,
  issuer: "store_api",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY") || "dev_fallback_secret"

config :store_api, dev_routes: true

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :swoosh, :api_client, false
