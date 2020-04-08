defmodule ElixirPhoenixLiveviewNQueenWeb.Router do
  use ElixirPhoenixLiveviewNQueenWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirPhoenixLiveviewNQueenWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/n_queen", NQueenLive  
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirPhoenixLiveviewNQueenWeb do
  #   pipe_through :api
  # end
end
