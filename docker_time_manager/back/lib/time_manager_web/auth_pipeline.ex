defmodule TodolistWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :time_manager,
  module: TodolistWeb.Guardian,
  error_handler: TodolistWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end