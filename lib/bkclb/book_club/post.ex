defmodule Bkclb.BookClub.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bkclb.Room

  schema "posts" do
    field :body, :string
    field :parent_id, :integer, default: nil
    field :username, :string, default: "Qanon"

    field :room_id, :integer

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:username, :body, :parent_id, :room_id])
    |> validate_required([:username, :body])
  end
end
