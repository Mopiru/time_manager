defmodule TodolistWeb.Router do
  use TodolistWeb, :router
  alias TodolistWeb.Guardian

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api", TodolistWeb do
    
    post "/users/sign_in", UserController, :sign_in
    options   "/users/sign_in", UserController, :nothing
   
    post "/users/sign_up", UserController, :sign_up
    options   "/users/sign_up", UserController, :nothing
    pipe_through :api
  end



  scope "/api/v1", TodolistWeb do
    pipe_through [:api, :jwt_authenticated]
    
    get "/workingtimes/:id/:worktimeID", WorkingtimesController, :showone
    options   "workingtimes/:id/:worktimeID", WorkingtimesController, :nothing
    
    get "/workingtimes/:userID", WorkingtimesController, :showUser
    options   "/workingtimes/:userID", WorkingtimesController, :nothing

    get "/clocks/:userID", ClocksController, :showUserClock
    ptions   "/clocks/:userID", ClocksController, :nothing

    resources "/users", UserController, except: [:new, :edit]
    options   "/users", UserController, :nothing

    resources "/workingtimes", WorkingtimesController, except: [:new, :edit]
    options   "/workingtimes", WorkingtimesController, :nothing

    resources "/clocks", ClocksController, except: [:new, :edit]
    options   "/clocks", ClocksController, :nothing

  end



  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: TodolistWeb.Telemetry
    end
  end
end
