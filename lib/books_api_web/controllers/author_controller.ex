defmodule BooksApiWeb.AuthorController do
  use BooksApiWeb, :controller

  alias BooksApi.Author

  plug BooksApiWeb.Plugs.RequireAuth when action in [:create, :update, :delete]
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

  def update(conn, %{"id" => id, "authors" => author_params}) do
    author = Author.get_author(id)

    with {:ok, %Author{} = author} <- Author.update_author(author, author_params) do
      render(conn, "show.json", author: author)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Author.get_author(id)

    with {:ok, %Author{}} <- Author.delete_author(author) do
      conn
        |> put_status(:ok)
        |> put_view(BooksApiWeb.SuccesseView)
        |> render("200.json", message: "author deleted")
    end
  end
end
