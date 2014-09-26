use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Hello2.Router,
    port: System.get_env("PORT"),
    ssl: false,
    host: "example.com",
    cookies: false,
    session_key: "_hello2_key",
    session_secret: "BDG8GOGD6ET_BE_#PQ!HD1DC*!JI^)F1LX^1%L#G3FQ#0!PU(&FJZP3F_FD1*O148V5337X3XVB0EB2"
    static_assets: true,
    static_assets_mount: "/static"

config :logger, :console,
  level: :info,
  metadata: [:request_id]
