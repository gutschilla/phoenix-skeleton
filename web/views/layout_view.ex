defmodule Skeleton4.LayoutView do
  use Skeleton4.Web, :view

  def get_session( conn, atom ) do
    Plug.Conn.get_session(conn, atom )
  end

  def get_user_id( conn ) do
    user = get_session( conn, :user )
    case user do
      nil -> nil
      %{ id: _id } -> user.id
    end
  end

end
