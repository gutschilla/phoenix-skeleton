defmodule Plug.AuthorizationRoles do 

  def init do
    []
  end
  def init( opts ) do
    {:ok, required } = Keyword.fetch( opts, :required )
    required
  end

  def call( conn, opt_required ) do
    
    user = Plug.Conn.get_session( conn, :user ) 
    
    roles_of_user  = Skeleton.User.Helper.roles_of %{ id: user.id }
    roles_required = ["admin"]
    
    missing = Set.difference(
      Enum.into( roles_required, HashSet.new ), 
      Enum.into( roles_of_user,  HashSet.new )
    ) |> Set.to_list

    is_authorized = length( missing ) == 0

    assert_authorized conn, is_authorized, missing

  end

  def assert_authorized( conn, true, _ ) do
    conn
  end

  def assert_authorized( conn, false, missing ) do
    conn |>  
    Plug.Conn.send_resp( 403, "Access denied. Missing user roles " <> Enum.join(", ") )
  end

end

