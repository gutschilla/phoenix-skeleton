# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :skeleton4, Skeleton4.Endpoint,
  url: [host: "localhost"],
  root: Path.expand("..", __DIR__),
  secret_key_base: "Xr16fZ4OwibbjqGi8gy8ectpRuGuPpECjCbG9ChpCfqE0W1Y3kJrDUmRNlWSFeQ3",
  debug_errors: false,
  pubsub: [name: Skeleton4.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]
  
# Configures Sessions
config :phoenix, MyApp.Router,
  session: [store: :memcached, key: "Skeleton4"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
