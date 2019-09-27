defmodule BooksApi.Author do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias BooksApi.Repo
  alias BooksApi.Author


  schema "authors" do
    field :first_name, :string
    field :last_name, :string

    has_many :books, BooksApi.Book
    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end

  def list_all do
    Author
    |> Repo.all
    |> Repo.preload(:books)
  end

  def create(attrs \\ %{}) do
    %Author{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def get_author(author_id) do
    Author
    |> Repo.get!(author_id)
    |> Repo.preload(:books)
  end
end
