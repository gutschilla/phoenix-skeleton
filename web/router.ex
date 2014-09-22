defmodule Hello2.Router do
    # using ets sessions
    use Hello2.Phoenix.Router

    get "/", Hello2.PageController, :index, as: :pages

    scope path: "/foo/bar" do
        get "/:some_key", Hello2.PageController, :foo_bar
    end

    scope path: "/auth" do
        get  "/",       Hello2.AuthController, :index ,    as: :auth_index
        post "/login",  Hello2.AuthController, :do_login,  as: :auth_login
        post "/logout", Hello2.AuthController, :do_logout, as: :auth_logout
    end


end
