defmodule Skeleton.PageController do
  use Skeleton.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def hello( conn, _params) do
    count = get_session(conn, :count) || 0
    conn  = put_session(conn, :count, count + 1 )
    text conn, "Hello #{count}"
  end
  
end
