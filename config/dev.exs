use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :skeleton, Skeleton.Endpoint,
  http: [port: 4000],
  url: [host: "127.0.0.1"], # point yout browser to http://127.0.0.1:4000, not http://localhost:4000 in dev mode
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]]

# Watch static and templates for browser reloading.
config :skeleton, Skeleton.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :skeleton, Skeleton.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "skeleton_dev_user",
  password: "skeleton_dev_pass",
  database: "skeleton_dev",
  hostname: "127.0.0.1",
  pool_size: 10 # The amount of database connections in the pool