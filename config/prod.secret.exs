use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :skeleton, Skeleton.Endpoint,
  secret_key_base: "k40PLP1kAhQHAjslbMA8c/9dp/1FptVYxH1fYVjT3YsqR/uN8HhUU+kj8WeXnZIr"


# this realy is the same database as in development, you may want to adjust this
config :skeleton, Skeleton.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "skeleton_dev_user",
  password: "skeleton_dev_pass",
  database: "skeleton_dev",
  hostname: "127.0.0.1",
  pool_size: 20 # The amount of database connections in the pool
