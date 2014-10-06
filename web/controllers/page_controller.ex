defmodule Hello2.PageController do
    use Phoenix.Controller

    @layout_module Hello2.NoLayoutView

    def index(conn, _params) do
        conn
        |> render "index", %{ message: "hello here", helpers: helpers() }
    end

    def foo_bar(conn, params ) do
        Logger.log( :debug, "some_key is: \"" <> params[ "some_key" ] <> "\"")
        conn
        |> render "foo_bar", %{ message: params[ "some_key" ] }
    end

    def date( conn, _params ) do
        alias Porcelain.Result
        %Result{out: output, status: status} = Porcelain.shell("date")
        text conn, output
    end

    def pdf( conn, _params ) do
        # pdf_file = PDF.generate("<html><body><h1>PDF TEST")
        # most of the times, we're generating PDFs from a template
        # remember to att .html extension as there's no content type without a conn
        html = Hello2.PageView.render "index.html", %{ message: "Yehaw! A PDF!"}
        pdf_file = PDF.generate( html )
        Logger.log(:info, "created PDF #{pdf_file}")
        conn = put_resp_content_type conn, "application/pdf"
        conn = send_file( conn, 200, ( pdf_file ), 0 ,  :all )
        File.rm! pdf_file
        conn
    end

    def not_found(conn, _params) do
        render conn, "not_found"
    end

    def error(conn, _params) do
        render conn, "error"
    end

    def helpers do
        %{
            path: %{
                root:   Hello2.Router.pages_path(:index),
                static: Hello2.Router.pages_path(:index) <> "static/",
            }
        }
    end
end
