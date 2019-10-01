defmodule BooksApiWeb.AuthorController do
  use BooksApiWeb, :controller

  alias BooksApi.Author

  plug BooksApiWeb.Plugs.RequireAuth when action in [:create, :update]
  action_fallback BooksApiWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", authors: Author.list_all)
  end

  def show(conn, %{"id" => id}) do
    author = Author.get_author(id)
    render(conn, "show.json", author: author)
  end

  def create(conn, %{"authors" => author_params}) do

    with {:ok, %Author{} = author} <- Author.create(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.author_path(conn, :show, author))
      |> render("show.json", author: Author.get_author(author.id))
    end
  end
end
