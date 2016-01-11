defmodule Skeleton.Router do
  use Skeleton.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end
  
  pipeline :admin do
    plug Plug.Authorization.Roles, %Skeleton.Authorization{ required: ["admin"] }
  end
  
  scope "/", Skeleton do
    pipe_through :browser # Use the default browser stack

    get "/",      PageController, :index
    get "/hello", PageController, :hello

  end

  scope "/auth", Skeleton do
    pipe_through :browser
    get  "/",       AuthController, :index
    post "/login",  AuthController, :login
    post "/logout", AuthController, :logout
  end

  scope "/admin", Skeleton do
    pipe_through :browser
    pipe_through :admin
    get "/roles", AdminController, :roles
    get "/users", AdminController, :users
  end

  # Other scopes may use custom stacks.
  # scope "/api", Skeleton do
  #   pipe_through :api
  # end
end
