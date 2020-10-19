defmodule Todolist.Task.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "task" do
    field :description, :string
    field :status, :string
    field :title, :string
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :description, :status])
    |> validate_required([:title, :description, :status])
    |> unique_constraint(:title)
  end
end
