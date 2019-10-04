defmodule BooksApiWeb.BookController do
  use BooksApiWeb, :controller

  alias BooksApi.Book

  plug BooksApiWeb.Plugs.RequireAuth when action in [:create, :update, :delete]
  action_fallback BooksApiWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", books: Book.list_all)
  end

  def show(conn, %{"id" => id}) do
    book = Book.get_book(id)
    render(conn, "show.json", book: book)
  end

  def create(conn, %{"books" => book_params}) do
    with {:ok, %Book{} = book} <- Book.create(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.book_path(conn, :show, book))
      |> render("show.json", book: Book.get_book(book.id))
    end
  end

  def update(conn, %{"id" => id, "books" => book_params}) do
    book = Book.get_book(id)

    with {:ok, %Book{} = book} <- Book.update_book(book, book_params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Book.get_book(id)

    with {:ok, %Book{}} <- Book.delete_book(book) do
      conn
        |> put_status(:ok)
        |> put_view(BooksApiWeb.SuccesseView)
        |> render("200.json", message: "Book deleted")
    end
  end
end
