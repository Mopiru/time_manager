defmodule TodolistWeb.Router do
  use TodolistWeb, :router
  alias TodolistWeb.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api", TodolistWeb do
    post "/users/sign_in", UserController, :sign_in
    post "/users/sign_up", UserController, :sign_up
    pipe_through :api
  end



  scope "/api/v1", TodolistWeb do
    pipe_through [:api, :jwt_authenticated]
    get "/workingtimes/:id/:worktimeID", WorkingtimesController, :showone
    get "/workingtimes/:userID", WorkingtimesController, :showUser
    get "/clocks/:userID", ClocksController, :showUserClock
    resources "/users", UserController, except: [:new, :edit]
    resources "/workingtimes", WorkingtimesController, except: [:new, :edit]
    resources "/clocks", ClocksController, except: [:new, :edit]
  end



  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: TodolistWeb.Telemetry
    end
  end
end
