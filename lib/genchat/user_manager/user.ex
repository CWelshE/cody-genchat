defmodule Genchat.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Genchat.{EncryptedField, PasswordField, HashField, UserManager.User}

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
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> create_email_hash
    |> create_pw_hash
    |> unique_constraint(:email_hash, :password_hash)
  end

  # If email exists in changeset, append hashed email addr
  defp create_email_hash(changeset) do
    if Map.has_key?(changeset.changes, :email) do
      changeset |> put_change(:email_hash, changeset.changes.email)
    else
      changeset
    end
  end

  # If password exists in changeset, store hashed password
  # (Would like to find a way to abstract these defs into one, if
  # possible, but not sure how to do that yet)
  defp create_pw_hash(changeset) do
    if Map.has_key?(changeset.changes, :password) do
      changeset |> put_change(:password_hash, changeset.changes.password)
    end
  end
end
