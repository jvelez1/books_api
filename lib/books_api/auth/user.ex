defmodule BooksApi.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :user_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :user_name, :password])
    |> validate_required([:email, :user_name, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:user_name)
    |> secure_password()
  end

  defp secure_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password))
  end

  defp secure_password(changeset) do
    changeset
  end
end
