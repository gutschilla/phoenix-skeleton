# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Hello2.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_hello2_key",
  session_secret: "BDG8GOGD6ET_BE_#PQ!HD1DC*!JI^)F1LX^1%L#G3FQ#0!PU(&FJZP3F_FD1*O148V5337X3XVB0EB2",
  catch_errors: true,
  debug_errors: false,
  error_controller: Hello2.PageController

config :phoenix, :code_reloader,
  enabled: false

config :phoenix, :template_engines,
  dtl: PhoenixDtl.Engine

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
