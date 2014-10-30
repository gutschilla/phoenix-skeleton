defmodule Skeleton2.PageController do
  use Phoenix.Controller
  alias Skeleton2.Router.Helpers

  plug :action

    def index(conn, _params) do
        conn
        |> put_layout( :none )
        |> render "index", %{
            message:  "hello here",
            helpers:   helpers(),
            say_hello: fn() -> "hello" end
        }
    end

    def pdf( conn, _params ) do
        # pdf_file = PDF.generate("<html><body><h1>PDF TEST")
        # most of the times, we're generating PDFs from a template
        # remember to att .html extension as there's no content type without a conn
        html = Skeleton2.PageView.render "index.html", %{ message: "Yehaw! A PDF!"}
        pdf_file = PdfGenerator.generate( html )
        Logger.log(:info, "created PDF #{pdf_file}")
        conn = put_resp_content_type conn, "application/pdf"
        conn = send_file( conn, 200, ( pdf_file ), 0 ,  :all )
        File.rm! pdf_file
        conn
    end

    def helpers do
        %{
            path: %{
                root:   Helpers.page_path(:index),
                static: Helpers.page_path(:index) <> "static/",
            }
        }
    end

    def not_found(conn, _params) do
        render conn, "not_found"
    end

    def error(conn, _params) do
        render conn, "error"
    end
end
