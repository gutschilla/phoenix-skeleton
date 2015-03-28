use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :skeleton4, Skeleton4.Endpoint,
  secret_key_base: "bzaui+SHRFxYTfdej43TqcriqHel6HzJvXET5+d8Az8ihVtvQsCy5bP0GPp/mgUA"

# Configure your database
config :skeleton4, Skeleton4.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "skeleton4_prod"
