defmodule Skeleton.AdminController do
  use Skeleton.Web, :controller

  # plug Plug.Authorization.Roles,
  #  %Skeleton.Authorization{ required: ["admin"] }

  def index( conn, _params ) do
    send_resp( conn, 200, "Allowed" ) 
  end

end
