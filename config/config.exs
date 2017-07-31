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

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
