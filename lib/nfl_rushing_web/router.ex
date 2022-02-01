defmodule NflRushingWeb.Router do
  use NflRushingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {NflRushingWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NflRushingWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", NflRushingWeb do
    pipe_through :api

    get "/records", RecordController, :index
    get "/records/report", ReportController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", NflRushingWeb do
  #   pipe_through :api
  # end
end
