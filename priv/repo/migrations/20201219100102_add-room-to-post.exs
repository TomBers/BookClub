defmodule :"Elixir.Bkclb.Repo.Migrations.Add-room-to-post" do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :room_id, references(:rooms, on_delete: :nothing)
    end

  end
end
