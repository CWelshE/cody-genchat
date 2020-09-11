defmodule Genchat.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Genchat.{EncryptedField, PasswordField, HashField, User}

  schema "users" do
    field :email, EncryptedField
    field :email_hash, HashField
    field :name, EncryptedField
    field :password, :binary, virtual: true
    field :password_hash, PasswordField

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
