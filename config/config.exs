# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :time_manager,
  namespace: Todolist,
  ecto_repos: [Todolist.Repo]

# Configures the endpoint
config :time_manager, TodolistWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5XKEaW8GDWWb0kILz8CjXZK8RhJYAdDELrsGHAQMosGMunyBeHva0WPDMW5PS1zL",
  render_errors: [view: TodolistWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Todolist.PubSub,
  live_view: [signing_salt: "8za2LpXb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
