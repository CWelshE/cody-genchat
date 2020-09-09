defmodule Genchat.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Genchat.{HashField, User}

  schema "users" do
    field :email, :binary
    field :email_hash, HashField
    field :name, :binary
    field :password_hash, :binary

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:email])
  end
end
