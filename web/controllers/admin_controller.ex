defmodule Skeleton.AdminController do
  use Skeleton.Web, :controller

  # plug Plug.Authorization.Roles,
  #  %Skeleton.Authorization{ required: ["admin"] }

  def users( conn, _params ) do
    send_resp( conn, 200, "Allowed" ) 
  end
  def roles( conn, _params ) do
    send_resp( conn, 200, "Allowed" ) 
  end

end
