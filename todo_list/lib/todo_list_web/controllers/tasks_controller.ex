defmodule TodolistWeb.TasksController do
  use TodolistWeb, :controller

  alias Todolist.Accounts
  alias Todolist.Accounts.Tasks

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    task = Accounts.list_task()
    render(conn, "index.json", task: task)
  end

  def create(conn, %{"tasks" => tasks_params}) do
    with {:ok, %Tasks{} = tasks} <- Accounts.create_tasks(tasks_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.tasks_path(conn, :show, tasks))
      |> render("show.json", tasks: tasks)
    end
  end

  def show(conn, %{"id" => id}) do
    tasks = Accounts.get_tasks!(id)
    render(conn, "show.json", tasks: tasks)
  end

  def update(conn, %{"id" => id, "tasks" => tasks_params}) do
    tasks = Accounts.get_tasks!(id)

    with {:ok, %Tasks{} = tasks} <- Accounts.update_tasks(tasks, tasks_params) do
      render(conn, "show.json", tasks: tasks)
    end
  end

  def delete(conn, %{"id" => id}) do
    tasks = Accounts.get_tasks!(id)

    with {:ok, %Tasks{}} <- Accounts.delete_tasks(tasks) do
      send_resp(conn, :no_content, "")
    end
  end
end
