defmodule Skeleton.AdminController do
  use Skeleton.Web, :controller

  plug Plug.AuthorizationRoles,
    required: ["admin"]

  def index( conn, _params ) do
    send_resp( conn, 200, "Allowed" ) 
  end

end
