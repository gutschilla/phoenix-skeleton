defmodule Skeleton3.AuthController do
    use Phoenix.Controller

    alias Skeleton3.Router.Helpers

    plug :action

    def index(conn, _params) do
        url_login  = Helpers.url( conn, Helpers.auth_path(:login)  )
        url_logout = Helpers.url( conn, Helpers.auth_path(:logout) )
        conn
        |> render( "index.html", %{
            url_login:  url_login,
            url_logout: url_logout,
        })
    end

    def login( conn, %{ "password" => password, "username" => username } ) do
        result = Skeleton3.User.Helper.auth( username, password )
        success = case result do
            { :ok, user } -> conn = put_session( conn, :user, user); true
            _ -> false
        end
        redirect conn, Helpers.auth_path(:index)
    end

    def login( conn, _ ) do
        json conn, JSON.encode!( %{ success: false, reason: "params must be username and password"  } )
    end

    def logout( conn, _params ) do
        current_user = get_session( conn, :user )
        result = case current_user do
            nil -> :not_authenticated
            _   -> :ok
        end
        if :ok == result do
            conn = delete_session( conn, :user )
        end
        redirect conn, Helpers.auth_path(:index)
    end

    ###

    def not_found(conn, _params) do
        render conn, "not_found"
    end

    def error(conn, _params) do
        render conn, "error"
    end

end
