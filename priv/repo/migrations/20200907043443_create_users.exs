defmodule Genchat.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :binary
      add :email_hash, :binary
      add :name, :binary
      add :password_hash, :binary

      timestamps()
    end

  end
end
