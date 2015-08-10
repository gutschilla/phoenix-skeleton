defmodule Skeleton.LayoutView do
  use Skeleton.Web, :view

  def get_session( conn, atom ) do
    Plug.Conn.get_session(conn, atom )
  end

  defp get_user( conn ) do
    get_session( conn, :user )
  end

  def get_user_id( conn ) do
    case get_user( conn ) do
      nil -> nil
      %{ id: id } -> %{ id: id }
    end
  end

  def get_user_roles( conn ) do
    case get_user( conn ) do
      nil         -> []
      %{ id: id } -> Skeleton.User.Helper.roles_of( %{ id: id } ) 
    end
  end

end
