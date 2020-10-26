defmodule TodolistWeb.WorkingtimesController do
  use TodolistWeb, :controller

  alias Todolist.Accounts
  alias Todolist.Accounts.Workingtimes
  import Ecto.Query
  alias Todolist.Repo

  action_fallback TodolistWeb.FallbackController



  #  ALL GET WORKING TIME BY USER ID START AND END
  def show(conn, %{"id" => id, "start" => param_start, "end" => param_end}) do
    workingtimes = from(u in Workingtimes, where: [user: ^id])
      |> Repo.all()
    render(conn, "show.json", workingtimes: workingtimes)
  end




  # GET WORKING BY USER ID
  def showUser(conn, %{"userID" => id}) do
    workingtimes = Repo.all(from(u in Workingtimes, where: u.user == ^id))
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def show(conn, %{"id" => id}) do
    workingtimes = Accounts.get_workingtimes!(id)
    render(conn, "show.json", workingtimes: workingtimes)
  end







  # NOT USE
  def index(conn, _params) do
    workingtimes = Accounts.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  # POST WORKTIME
  def create(conn, %{"workingtimes" => workingtimes_params}) do
    with {:ok, %Workingtimes{} = workingtimes} <- Accounts.create_workingtimes(workingtimes_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtimes_path(conn, :show, workingtimes))
      |> render("show.json", workingtimes: workingtimes)
    end
  end

 # GET BY USER ID AND WORKTIME ID
  def showone(conn, %{"id" => id, "worktimeID" => worktimeID}) do
    workingtimes = Accounts.get_workingtimes!(worktimeID)
    render(conn, "show.json", workingtimes: workingtimes)
  end

  # UPDATE WORKING BY WIRKING ID
  def update(conn, %{"id" => id, "workingtimes" => workingtimes_params}) do
    workingtimes = Accounts.get_workingtimes!(id)

    with {:ok, %Workingtimes{} = workingtimes} <- Accounts.update_workingtimes(workingtimes, workingtimes_params) do
      render(conn, "show.json", workingtimes: workingtimes)
    end
  end
  # DELETE WORKING BY WORKING ID
  def delete(conn, %{"id" => id}) do
    workingtimes = Accounts.get_workingtimes!(id)

    with {:ok, %Workingtimes{}} <- Accounts.delete_workingtimes(workingtimes) do
      send_resp(conn, :no_content, "")
    end
  end
end
