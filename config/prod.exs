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

config :phoenix, Skeleton2.Router,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "ykra3/SIekQYAeCjsyNIUDxuelKgo2C+Zdp75agH7+2Bj0ShOhxohpfV37QUioGd9CIPtx8p9HPOwW3w7Q9B6A=="

config :logger, :console,
  level: :info
