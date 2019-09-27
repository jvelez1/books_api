defmodule BooksApiWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller
  def init(_params) do
  end

  def call(conn, _params) do
    if get_session(conn, :current_user_id) do
      conn
    else
      conn
        |> put_status(:unauthorized)
        |> put_view(BooksApiWeb.ErrorView)
        |> render("401.json", message: "You must logged in")
        |> halt
    end
  end
end
