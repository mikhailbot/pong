# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pong,
  ecto_repos: [Pong.Repo]

# Configures the endpoint
config :pong, PongWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "p3xLceeMAEck5AKba9IpvA6MlsDQNt4K8RPmuxucsleeMToPB+J0U6NFZcL9WvOt",
  render_errors: [view: PongWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pong.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Bamboo Mailer
config :pong, Pong.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: {:system, "SMTP_DOMAIN"},
  port: {:system, "SMTP_PORT"},
  username: {:system, "SMTP_USERNAME"},
  password: {:system, "SMTP_PASSWORD"},
  tls: :if_available, # can be `:always` or `:never`
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"], # or {":system", ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  ssl: false, # can be `true`
  retries: 1

# Configures MJML email templates
config :phoenix, :template_engines,
  mjml: PhoenixMjml.Engine

# Configures Quantum schedule
config :pong, Pong.Scheduler,
  jobs: [
    {"* * * * *", {Pong.Monitors, :check_hosts, []}}, # Ping all hosts every minute
    {"* * * * *", {Pong.Reports, :check_status, []}}, # Check status of all hosts every minute
    {"5 * * * *", {Pong.Redis, :delete_old_checks, []}} # Remove old checks every hour
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
