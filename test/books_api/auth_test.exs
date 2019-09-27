defmodule BooksApi.AuthTest do
  use BooksApi.DataCase

  alias BooksApi.Auth

  describe "users" do
    alias BooksApi.Auth.User

    @valid_attrs %{email: "some email", password: "some password", user_name: "some user_name"}
    @update_attrs %{
        email: "some updated email",
        password: "some updated password",
        user_name: "some updated user_name"
      }
    @invalid_attrs %{email: nil, password: nil, user_name: nil}


    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user_fixture()
      assert Auth.list_users() != []
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Auth.get_user!(user.id).id == user.id
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Auth.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.user_name == "some user_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Auth.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.user_name == "some updated user_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, @invalid_attrs)
      assert user.id == Auth.get_user!(user.id).id
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Auth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Auth.change_user(user)
    end

    test "authenticate/2 authenticates the user" do
      user = user_fixture()
      assert {:error, "Invalid auth"} = Auth.authenticate("wrong email", "")
      assert {:ok, authenticated_user} = Auth.authenticate(user.email, @valid_attrs.password)
      assert %{user | password: nil} == authenticated_user
    end
  end
end
