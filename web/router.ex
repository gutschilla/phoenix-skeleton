defmodule Skeleton.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Skeleton do
    pipe_through :browser # Use the default browser stack

    get "/",      PageController, :index
    get "/hello", PageController, :hello
    
    resources "/userroles", UserroleController

  end

  scope "/auth", Skeleton do
    pipe_through :browser
    get  "/",       AuthController, :index
    post "/login",  AuthController, :login
    post "/logout", AuthController, :logout
  end

  scope "/admin", Skeleton do
    pipe_through :browser
    get "/", AdminController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Skeleton do
  #   pipe_through :api
  # end
end
