defmodule Bkclb.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bkclb.BookClub.Post

  schema "rooms" do
    field :name, :string

    has_many :posts, Post, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
