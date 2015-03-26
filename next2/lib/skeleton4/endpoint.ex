defmodule Skeleton4.Endpoint do
  use Phoenix.Endpoint, otp_app: :skeleton4

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :skeleton4,
    only: ~w(css images js favicon.ico robots.txt)

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_skeleton4_key",
    signing_salt: "FWKQ7dhO",
    encryption_salt: "x29Pp2vo"

  plug :router, Skeleton4.Router
end
