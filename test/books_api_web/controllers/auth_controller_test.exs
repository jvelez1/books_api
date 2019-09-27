defmodule BooksApiWeb.AuthControllerTest do
  use BooksApiWeb.ConnCase

  alias BooksApi.Auth

  @current_user_attrs %{
    email: "some current user email",
    user_name: "some current user name",
    password: "some current user password"
  }

  def fixture(:user) do
    {:ok, user} = Auth.create_user(@current_user_attrs)
    user
  end



  describe "create auth" do
    setup [:create_user]

    test "renders user when user credentials are good", %{conn: conn, user: user} do
      conn =
        post(
          conn,
            Routes.auth_path(conn, :create, %{
              email: @current_user_attrs.email,
              password: @current_user_attrs.password
            })
          )

      assert json_response(conn, 200) == %{
          "id" => user.id,
          "email" => user.email,
          "user_name" => user.user_name
      }
    end

    test "renders errors when user credentials are bad", %{conn: conn} do
      conn =
        post(conn, Routes.auth_path(conn, :create, %{email: "non-existent email", password: ""}))
        assert json_response(conn, 401)["errors"] == %{"detail" => "Invalid auth"}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
