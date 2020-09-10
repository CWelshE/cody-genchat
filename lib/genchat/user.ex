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
    |> create_email_hash
    |> unique_constraint(:email_hash)
  end

  # If email exists in changeset, append hashed email addr
  defp create_email_hash(changeset) do
    if Map.has_key?(changeset.changes, :email) do
      changeset |> put_change(:email_hash, changeset.changes.email)
    else
      changeset
    end
  end
end
