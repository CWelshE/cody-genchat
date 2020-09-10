# Encryption processing for all generic text fields, and other plaintext
# data. Things defined in this Type will be handled by Ecto.

alias Genchat.AES

defmodule Genchat.EncryptedField do
  @behaviour Ecto.Type

  def type, do: :binary

  # Stringify processed data
  def cast(val) do
    {:ok, to_string(val)}
  end

  # Turn our raw value into ciphertext prior to committing anything to
  # the database.
  def dump(val) do
    cipher = val |> to_string |> AES.encrypt()
    {:ok, cipher}
  end

  # Decrypt requested data
  def load(val) do
    {:ok, AES.decrypt(val)}
  end

  # As in our other types, not used in our case
  def embed_as(_), do: :self

  # Simple comparison to find out if a changeset needs to be committed
  def equal?(x, y), do: x == y
end
