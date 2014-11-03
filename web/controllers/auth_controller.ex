defmodule Skeleton2.AuthController do
    use Phoenix.Controller

    import Skeleton2.Helpers, only: [ apply_defaults: 2 ]
    alias Skeleton2.Router.Helpers

    plug :action

    def index(conn, _params) do
        url_login  = Helpers.auth_path(:login)
        url_logout = Helpers.auth_path(:logout)
        conn
        |> put_layout( :none )
        |> render( "index", apply_defaults( conn,
            %{
                url_login:  url_login,
                url_logout: url_logout,
            }
        ))
    end

    # TODO: put into Helper
    def is_json( conn ) do
        {"accept",       accept       } = List.keyfind( conn.req_headers, "accept", 0 )
        {"content-type", content_type } = List.keyfind( conn.req_headers, "content-type", 0 )
        String.contains?( accept, "application/json") || String.contains?( content_type, "application/json")
    end

    def login( conn, %{ "password" => password, "username" => username } ) do
        result = Skeleton2.User.Helper.auth( username, password )
        success = case result do
            { :ok, user } -> conn = put_session( conn, :user, user); true
            _ -> false
        end
        case is_json( conn ) do
            true  -> json conn, JSON.encode!( %{ success: success } )
            false -> redirect conn, Helpers.auth_path(:index)
        end
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
        case is_json( conn ) do
            true  -> json conn, JSON.encode!( %{ success: result == :ok, reason: result } )
            false -> redirect conn, Helpers.auth_path(:index)
        end
    end

    ###

    def not_found(conn, _params) do
        render conn, "not_found"
    end

    def error(conn, _params) do
        render conn, "error"
    end

end
