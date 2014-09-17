defmodule Hello2.Router do
  use Phoenix.Router

  get "/", Hello2.PageController, :index, as: :pages

end
