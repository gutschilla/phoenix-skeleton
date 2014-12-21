use Mix.Config

config :skeleton3, Skeleton3.Endpoint,
  http: [port: System.get_env("PORT") || 4001]
