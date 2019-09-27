defmodule BooksApi.Author do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias BooksApi.Repo
  alias BooksApi.Author


  schema "authors" do
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end

  def list_all do
    Repo.all(Author)
  end

  def create(attrs \\ %{}) do
    %Author{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def get_author(author_id), do: Repo.get!(Author, author_id)
end
