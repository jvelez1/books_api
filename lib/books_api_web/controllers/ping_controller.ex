defmodule BooksApiWeb.PingController do
  use BooksApiWeb, :controller
  def index(conn, _params) do
    text conn, "PONG!"
  end
end
