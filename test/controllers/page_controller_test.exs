defmodule Skeleton4.PageControllerTest do
  use Skeleton4.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert conn.resp_body =~ "Welcome to Phoenix!"
  end
end
