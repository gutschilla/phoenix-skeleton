defmodule Plug.Authorization.Roles do 

  alias Plug.Authorization.Roles.Config

  def init do
    []
  end
  
  def init( opts ) do
    opts 
  end

  def call( conn, opts ) do
    roles_of_user  = Config.get_userroles( opts ).( conn )
    roles_required = Config.required( opts )
    
    { is_authorized, missing } = check_authorized( roles_of_user, roles_required )
    assert_authorized conn, is_authorized, missing
  end

  def check_authorized( roles_of_user, roles_required ) do
    missing = Set.difference(
      Enum.into( roles_required, HashSet.new ), 
      Enum.into( roles_of_user,  HashSet.new )
    ) |> Set.to_list
    is_authorized = length( missing ) == 0
    { is_authorized, missing }
  end

  def assert_authorized( conn, true, _ ) do
    conn
  end

  def assert_authorized( conn, false, missing ) do
    conn  
    |> Plug.Conn.send_resp( 403, "Access denied. Missing user roles " <> Enum.join( missing, ", ") )
    |> Plug.Conn.halt 
  end

end

