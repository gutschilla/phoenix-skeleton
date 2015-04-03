defmodule Skeleton4Test do
  use ExUnit.Case

  test "Generate and Verify password" do
    user = %Skeleton4.User{ username: "testman 1" }
    user = Skeleton4.User.Helper.set_password( user, "testpassword" )
    assert Skeleton4.User.Helper.verify_password( user, "testpassword" )
  end
end
