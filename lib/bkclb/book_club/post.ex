defmodule Bkclb.BookClub.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :parent_id, :integer, default: nil
    field :username, :string, default: "Qanon"

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:username, :body, :parent_id])
    |> validate_required([:username, :body])
  end
end
