defmodule Hello2.AuthController do
    use Phoenix.Controller
    require Record
    Record.defrecord :credentials, [ username: "", password: ""]

    @layout_module Hello2.NoLayoutView

    def index(conn, _params) do
        current_user = get_session( conn, :username )
        conn
        |> render "index",
        %{
            login_action:     "/auth/login", #Hello2.Router.do_login_path,
            logout_action:    "/auth/logout",
            current_user:     current_user,
            is_authenticated: current_user != nil
        }
    end

    def do_login( conn, %{ "password" => password, "username" => username } ) do
        credentials = credentials( username: username, password: password )
        login_result = authenticate( :db_plain, credentials )
        conn = put_session( conn, :username, username )
        json conn, JSON.encode!( %{ success: login_result == :ok, reason: login_result } )
    end

    def do_login( conn, _ ) do
        json conn, JSON.encode!( %{ success: false, reason: "params must be username and password"  } )
    end

    def do_logout( conn, _params ) do
        current_user = get_session( conn, :username )
        logout_result = case current_user do
            nil -> :not_authenticated
            _   -> :ok
        end
        if :ok == logout_result do
            conn = delete_session( conn, :username )
        end
        json conn, JSON.encode!( %{ success: logout_result == :ok, reason: logout_result } )
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
        query = from u in Hello2.User, where: u.username == ^str_username
        case Repo.all( query ) do
            []           -> :unknown
            [ user ]     -> check_password( :db_plain, user, password )
            [ _user | _ ] -> :not_unique
        end
    end

end
