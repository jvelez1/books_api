defmodule BooksApi.Book do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias BooksApi.Repo
  alias BooksApi.Book

  schema "books" do
    field :description, :string
    field :title, :string
    field :year, :integer

    belongs_to :author, BooksApi.Author
    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :description, :year, :author_id])
    |> validate_required([:title, :description, :year])
    |> assoc_constraint(:author)
  end

  def list_all do
    Book
    |> Repo.all
    |> Repo.preload(:author)
  end

  def create(attrs \\ %{}) do
    %Book{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def get_book(book_id) do
    Book
    |> Repo.get!(book_id)
    |> Repo.preload(:author)
  end

  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end
end
