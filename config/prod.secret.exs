use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :skeleton, Skeleton.Endpoint,
  secret_key_base: "k40PLP1kAhQHAjslbMA8c/9dp/1FptVYxH1fYVjT3YsqR/uN8HhUU+kj8WeXnZIr"

# Configure your database
config :skeleton, Skeleton.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "skeleton_prod",
  size: 20 # The amount of database connections in the pool
