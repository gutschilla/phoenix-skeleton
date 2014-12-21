defmodule Skeleton3.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Skeleton3 do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", Skeleton3 do
    get  "/",       AuthController, :index  , as: :auth
    post "/login",  AuthController, :login  , as: :auth
    post "/logout", AuthController, :logout , as: :auth
  end
  
  # Other scopes may use custom stacks.
  # scope "/api", Skeleton3 do
  #   pipe_through :api
  # end
  
end
