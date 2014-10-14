defmodule Skeleton2.AuthController do
    use Phoenix.Controller
    require Record
    Record.defrecord :credentials, [ username: "", password: ""]
    alias Skeleton2.Router.Helpers

    plug :action

    def index(conn, _params) do
        current_user = get_session( conn, :username )
        # TODO: get this automagically
        url_login  = Helpers.auth_path(:login)  |> Helpers.url
        url_logout = Helpers.auth_path(:logout) |> Helpers.url
        conn
        |> put_layout( :none )
        |> render "index",
        %{
            url_login:        url_login,
            url_logout:       url_logout,
            current_user:     current_user,
            is_authenticated: current_user != nil
        }
    end

    def is_json( conn ) do
        {"accept",       accept       } = List.keyfind( conn.req_headers, "accept", 0 )
        {"content-type", content_type } = List.keyfind( conn.req_headers, "content-type", 0 )
        String.contains?( accept, "application/json") || String.contains?( content_type, "application/json")
    end

    def login( conn, %{ "password" => password, "username" => username } ) do
        credentials = credentials( username: username, password: password )
        login_result = authenticate( :db_plain, credentials )

        if login_result == :ok do
            conn = put_session( conn, :username, username )
        end

        case is_json( conn ) do
            true  -> json conn, JSON.encode!( %{ success: login_result == :ok, reason: login_result } )
            false -> redirect conn, Helpers.auth_path(:index)
        end

    end

    def login( conn, _ ) do
        json conn, JSON.encode!( %{ success: false, reason: "params must be username and password"  } )
    end

    def logout( conn, _params ) do
        current_user = get_session( conn, :username )
        logout_result = case current_user do
            nil -> :not_authenticated
            _   -> :ok
        end
        if :ok == logout_result do
            conn = delete_session( conn, :username )
        end
        case is_json( conn ) do
            true  -> json conn, JSON.encode!( %{ success: logout_result == :ok, reason: logout_result } )
            false -> redirect conn, Helpers.auth_path(:index)
        end
    end

    def not_found(conn, _params) do
        render conn, "not_found"
    end

    def error(conn, _params) do
        render conn, "error"
    end

    def get_users do
        %{ "testuser": "testpass" }
    end

    def check_password( :db_plain, user, password ) do
        case user.password_hash == password do
            true  -> :ok
            false -> :wrong_password
        end
    end

    def authenticate( :plain, {:credentials, str_username, password} ) do
        username = String.to_atom( str_username )
        users = get_users()
        case Map.has_key?( users, username) do
            true  -> if users[ username ] == to_string( password ) do :ok else :wrong_password end
            false -> :unknown
        end
    end

    def authenticate( :db_plain, {:credentials, str_username, password} ) do
        import Ecto.Query
        query = from u in Skeleton2.User, where: u.username == ^str_username
        case Repo.all( query ) do
            []           -> :unknown
            [ user ]     -> check_password( :db_plain, user, password )
            [ _user | _ ] -> :not_unique
        end
    end

end
