defmodule Plug.Authorization.Roles do 

  def init do
    []
  end
  def init( opts ) do
    {:ok, required } = Keyword.fetch( opts, :required )
    required
  end

  def call( conn, opt_required ) do
    roles_required = ["admin"]
    roles_of_user  = get_userroles_from_session( conn )
    missing = Set.difference(
      Enum.into( roles_required, HashSet.new ), 
      Enum.into( roles_of_user,  HashSet.new )
    ) |> Set.to_list

    is_authorized = length( missing ) == 0

    assert_authorized conn, is_authorized, missing

  end

  def get_userroles_from_session( conn ) do
    user = Plug.Conn.get_session( conn, :user ) 
    case user do
      nil -> []
      %{ id: user_id } -> Skeleton.User.Helper.roles_of %{ id: user.id }
      _   -> throw( :invalid_user_session_format )
    end
    # roles_of_user = Skeleton.User.Helper.roles_of %{ id: user.id }
  end

  def assert_authorized( conn, true, _ ) do
    conn
  end

  def assert_authorized( conn, false, missing ) do
    conn |>  
    Plug.Conn.send_resp( 403, "Access denied. Missing user roles " <> Enum.join( missing, ", ") )
  end

end

