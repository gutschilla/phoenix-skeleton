defmodule Skeleton.AuthView do
  use Skeleton.Web, :view

  def get_session( conn, atom ) do
    Plug.Conn.get_session(conn, atom )
  end

end
