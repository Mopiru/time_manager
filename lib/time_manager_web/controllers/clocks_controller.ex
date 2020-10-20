defmodule TodolistWeb.ClocksController do
  use TodolistWeb, :controller

  alias Todolist.Accounts
  alias Todolist.Accounts.Clocks

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    clocks = Accounts.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clocks" => clocks_params}) do
    with {:ok, %Clocks{} = clocks} <- Accounts.create_clocks(clocks_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clocks_path(conn, :show, clocks))
      |> render("show.json", clocks: clocks)
    end
  end

  def show(conn, %{"id" => id}) do
    clocks = Accounts.get_clocks!(id)
    render(conn, "show.json", clocks: clocks)
  end

  def update(conn, %{"id" => id, "clocks" => clocks_params}) do
    clocks = Accounts.get_clocks!(id)

    with {:ok, %Clocks{} = clocks} <- Accounts.update_clocks(clocks, clocks_params) do
      render(conn, "show.json", clocks: clocks)
    end
  end

  def delete(conn, %{"id" => id}) do
    clocks = Accounts.get_clocks!(id)

    with {:ok, %Clocks{}} <- Accounts.delete_clocks(clocks) do
      send_resp(conn, :no_content, "")
    end
  end
end
