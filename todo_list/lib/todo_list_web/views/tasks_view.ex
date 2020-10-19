defmodule TodolistWeb.TasksView do
  use TodolistWeb, :view
  alias TodolistWeb.TasksView

  def render("index.json", %{task: task}) do
    %{data: render_many(task, TasksView, "tasks.json")}
  end

  def render("show.json", %{tasks: tasks}) do
    %{data: render_one(tasks, TasksView, "tasks.json")}
  end

  def render("tasks.json", %{tasks: tasks}) do
    %{id: tasks.id,
      title: tasks.title,
      description: tasks.description,
      status: tasks.status}
  end
end
