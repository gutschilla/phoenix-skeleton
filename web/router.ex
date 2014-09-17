defmodule Hello2.Router do
    use Phoenix.Router
    
    get "/", Hello2.PageController, :index, as: :pages
    
    scope path: "/foo/bar" do
        get "/:some_key", Hello2.PageController, :foo_bar
    end

end
