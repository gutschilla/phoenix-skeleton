defmodule Skeleton4.Endpoint do
  use Phoenix.Endpoint, otp_app: :skeleton4

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :skeleton4,
    only: ~w(css images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

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
