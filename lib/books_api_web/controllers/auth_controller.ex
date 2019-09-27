defmodule BooksApiWeb.AuthController do
  use BooksApiWeb, :controller

  alias BooksApi.Auth
  alias BooksApi.Auth.User

  def create(conn, %{"email" => email, "password" => password}) do
    case Auth.authenticate(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_status(:ok)
        |> put_view(BooksApiWeb.UserView)
        |> render("user.json", user: user)
       {:error, message} ->
        conn
        |> delete_session(:current_user_id)
        |> put_status(:unauthorized)
        |> put_view(BooksApiWeb.ErrorView)
        |> render("401.json", message: message)
    end
  end
end
