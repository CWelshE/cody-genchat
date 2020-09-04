defmodule Genchat.Repo do
  use Ecto.Repo,
    otp_app: :genchat,
    adapter: Ecto.Adapters.Postgres
end
