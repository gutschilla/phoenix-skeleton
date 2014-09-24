defmodule Hello2.Router do
    use Phoenix.Router
    alias Phoenix.Plugs
    alias Phoenix.Config
    # be sure to set config.cookies to false

    key = Config.router!(__MODULE__, [:session_key])
    plug Plug.Session,  store: :memcached, key: key, table: :memcached_sessions
    plug Plugs.SessionFetcher

    IO.puts Config.router!(:"Elixir.Hello2.Router", [:session_key])


    get "/",     Hello2.PageController, :index, as: :pages
    get "/date", Hello2.PageController, :date

    scope path: "/foo/bar" do
        get "/:some_key", Hello2.PageController, :foo_bar
    end

    scope path: "/auth" do
        get  "/",       Hello2.AuthController, :index ,    as: :auth_index
        post "/login",  Hello2.AuthController, :do_login,  as: :auth_login
        post "/logout", Hello2.AuthController, :do_logout, as: :auth_logout
    end


end
