defmodule Hello2.AuthController do
    use Phoenix.Controller
  
    def index(conn, _params) do
        conn
        |> assign_layout(:none)
        |> render "index", %{ message: "hello here" }
    end

    def login(conn, _params) do
        conn
        |> assign_layout(:none)
        |> render "index", %{ message: "hello here" }
    end
  
    def not_found(conn, _params) do
        render conn, "not_found"
    end
  
    def error(conn, _params) do
        render conn, "error"
    end
end

defmodule Hello2.AuthView do
  use Hello2.Views
end
