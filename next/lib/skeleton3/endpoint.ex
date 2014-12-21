defmodule Skeleton3.Endpoint do
  use Phoenix.Endpoint, otp_app: :skeleton3

  plug Plug.Static,
    at: "/static/", from: :skeleton3

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
    store: :memcached,
    key: "_skeleton3_key",
    table: :memcached_sessions,
    signing_salt: "t+ZH96Tc",
    encryption_salt: "131Rryiy"

  plug :router, Skeleton3.Router
end
