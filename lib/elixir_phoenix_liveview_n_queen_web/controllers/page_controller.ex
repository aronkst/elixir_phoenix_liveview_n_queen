defmodule ElixirPhoenixLiveviewNQueenWeb.PageController do
  use ElixirPhoenixLiveviewNQueenWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
