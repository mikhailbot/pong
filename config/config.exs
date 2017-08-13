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

config :pong, Pong.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.domain",
  port: 1025,
  username: "your.name@your.domain", # or {:system, "SMTP_USERNAME"}
  password: "pa55word", # or {:system, "SMTP_PASSWORD"}
  tls: :if_available, # can be `:always` or `:never`
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"], # or {":system", ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  ssl: false, # can be `true`
  retries: 1

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
