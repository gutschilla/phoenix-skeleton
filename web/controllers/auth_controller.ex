defmodule Hello2.AuthController do
    use Phoenix.Controller
    require Record
    Record.defrecord :user, [ username: "", password: ""]

    def index(conn, _params) do
        conn
        |> assign_layout(:none)
        |> render "index",
        %{ login_action: Hello2.Router.do_login_path }
    end

    def do_login( conn, %{ "password" => password, "username" => username } ) do
        credentials = user( username: username, password: password )
        login_result = authenticate( credentials )
        json conn, JSON.encode!( %{ success: login_result == :ok, reason: login_result } )
    end

    def do_login( conn, _ ) do
        json conn, JSON.encode!( %{ success: false, reason: "params must be username and password"  } )
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

    def authenticate( {:user, str_username, password} ) do
        username = String.to_atom( str_username )
        users = get_users()
        case Map.has_key?( users, username) do
            true  -> if users[ username ] == to_string( password ) do :ok else :wrong end
            false -> :unknown
        end
    end

end
