defmodule Skeleton2.Router do
  use Phoenix.Router

  scope "/" do
    # Use the default browser stack.
    pipe_through :browser

    get "/",    Skeleton2.PageController, :index
    get "/pdf", Skeleton2.PageController, :pdf

    scope path: "/auth" do
        get  "/",       Skeleton2.AuthController, :index  , as: :auth
        post "/login",  Skeleton2.AuthController, :login  , as: :auth
        post "/logout", Skeleton2.AuthController, :logout , as: :auth
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api" do
  #   pipe_through :api
  # end

    pipeline :browser do
        plug :super
    end

end
