use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :skeleton, Skeleton.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database, OMG, my test run on the same database as in dev.
config :skeleton, Skeleton.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "skeleton_dev_user",
  password: "skeleton_dev_pass",
  database: "skeleton_dev",
  hostname: "127.0.0.1",
  pool: Ecto.Adapters.SQL.Sandbox
