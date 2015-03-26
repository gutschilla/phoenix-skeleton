defmodule Skeleton4.PageController do
  use Skeleton4.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def hello( conn, _params) do
    count = get_session(conn, :count) || 0
    conn  = put_session(conn, :count, count + 1 )
    text conn, "Hello #{count}"
  end
  
end
