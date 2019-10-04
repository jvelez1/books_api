defmodule BooksApiWeb.SuccesseView do
  use BooksApiWeb, :view

  def render("200.json", %{message: message}) do
    %{ok: %{detail: message}}
  end
end
