defmodule Hello2.PageController do
    use Phoenix.Controller
  
    def index(conn, _params) do
        conn
        |> assign_layout(:none)
        |> render "index", %{ message: "hello here" }
    end
  
    def foo_bar(conn, params ) do
        Logger.log( :debug, "some_key is: \"" <> params[ "some_key" ] <> "\"")
        conn
        |> assign_layout(:none)
        |> render "foo_bar", %{ message: params[ "some_key" ] }
    end
  
    def not_found(conn, _params) do
        render conn, "not_found"
    end
  
    def error(conn, _params) do
        render conn, "error"
    end
end
