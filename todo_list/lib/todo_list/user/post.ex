defmodule Todolist.User.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :frist_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:frist_name, :last_name])
    |> validate_required([:frist_name, :last_name])
  end
end
