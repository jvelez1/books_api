defmodule BooksApiWeb.Router do
  use BooksApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  scope "/api", BooksApiWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    resources "/auth", AuthController, only: [:create]
    resources "/ping", PingController, only: [:index]
    resources "/authors", AuthorController, only: [:index, :create, :show]
    resources "/books", BookController, only: [:index, :create, :show]
  end
end
