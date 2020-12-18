defmodule Bkclb.Repo do
  use Ecto.Repo,
    otp_app: :bkclb,
    adapter: Ecto.Adapters.Postgres
end
