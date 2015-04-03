defmodule Skeleton4.AuthController do
  use Skeleton4.Web, :controller
  alias Skeleton4.Router.Helpers

  plug :action

  @path_to_index Skeleton4.Router.Helpers.auth_path( Skeleton4.Endpoint, :index )

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def login( conn, %{ "username" => username, "password" => password } ) do
    user = Skeleton4.User.Helper.get_by_username username
    verify_password( conn, user, password )
  end

  def login( conn, _ ) do
    conn 
    |> put_flash( :error, "username or password missing")
    |> redirect( to: Helpers.auth_path( conn, :index )  )
  end

  def verify_password( conn, nil, _ ) do 
    # nil means: user not found
    conn 
    |> put_flash( :login_failure, true )
    |> redirect( to: Helpers.auth_path( conn, :index ) )
  end

  def verify_password( conn, user, password ) do
    # check user's password
    result = Skeleton4.User.Helper.verify_password user, password
 
    if result do
        conn = put_flash( conn, :login_success, true )
        conn = put_session( conn, :user, user )
    else 
      conn = put_flash( conn, :login_failure, true )
    end
    
    redirect conn, to: @path_to_index 
  end

  def logout( conn, _params ) do
    conn
    |> put_session( :user, nil )
    |> redirect( to: Helpers.auth_path( conn, :index ) )
  end  

end
