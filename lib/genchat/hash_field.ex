# A custom type for Ecto to validate our data before storing it
defmodule Genchat.HashField do
  @behaviour Ecto.Type

  # Returns the expected type for this data
  def type, do: :binary

  # Convert data into the form you want it to live in within the
  # database itself
  def cast(val) do
    {:ok, to_string(val)}
  end

  # Any data processing usually happens in this function within new Ecto
  # types (that are user-defined).
  def dump(val) do
    {:ok, hash(val)}
  end

  # Just retrieves the value
  def load(val) do
    {:ok, val}
  end

  # Unused in this case, but still required by Ecto types
  def embed_as(_), do: :self

  # Ecto uses this in changeset computations
  def equal?(x, y), do: x == y

  # Helper hash fn for above
  def hash(val) do
    :crypto.hash(:sha256, val <> gen_salt(val))
  end

  # Generate a salt from the input val and the Phoenix Secret Key (which
  # is generated when you create a new application).
  defp gen_salt(val) do
    phx_sec_key = GenchatWeb.Endpoint.config(:secret_key_base)
    :crypto.hash(:sha256, val <> phx_sec_key)
  end
end
