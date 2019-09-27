defmodule BooksApiWeb.BookView do
  use BooksApiWeb, :view
  alias BooksApiWeb.BookView
  alias BooksApiWeb.AuthorView

  def render("index.json", %{books: books}) do
    %{data: render_many(books, BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, BookView, "book.json")}
  end


  def render("book.json", %{book: book}) do
    %{id: book.id,
      title: book.title,
      description: book.description,
      year: book.year,
      author: render_one(book.author, AuthorView, "simple_author.json")}
  end

  def render("simple_book.json", %{book: book}) do
    %{id: book.id,
      title: book.title,
      description: book.description,
      year: book.year }
  end
end
