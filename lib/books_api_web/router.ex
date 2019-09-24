defmodule BooksApiWeb.Router do
  use BooksApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BooksApiWeb do
    pipe_through :api
    resources "/ping", PingController, only: [:index]
  end
end
