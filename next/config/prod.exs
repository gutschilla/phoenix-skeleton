use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :skeleton3, Skeleton3.Endpoint,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "VG6EZnXOmKXe6S73uzhu4f5uwESFSC4dHlgtbS/WKR4mzyEsIFvajRSJ7ZDebbRc"

config :logger,
  level: :info
