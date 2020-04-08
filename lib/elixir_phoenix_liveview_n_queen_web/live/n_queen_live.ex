defmodule ElixirPhoenixLiveviewNQueenWeb.NQueenLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>N Queens</h1>
    """
  end
end