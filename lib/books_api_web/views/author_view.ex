defmodule BooksApiWeb.AuthorView do
  use BooksApiWeb, :view
  alias BooksApiWeb.AuthorView
  alias BooksApiWeb.BookView

  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end


  def render("author.json", %{author: author}) do
    %{id: author.id,
      first_name: author.first_name,
      last_name: author.last_name,
      books: render_many(author.books, BookView, "simple_book.json")}
  end

  def render("simple_author.json", %{author: author}) do
    %{id: author.id,
      first_name: author.first_name,
      last_name: author.last_name }
  end
end
