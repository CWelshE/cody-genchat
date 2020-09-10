# Ecto Data Type for automatically hashing passwords with the Argon2
# algorithm

defmodule Genchat.PasswordField do
  # Passwords are binary
  def type, do: :binary

  # Stringify the password before storing
  def cast(val) do
    {:ok, to_string(val)}
  end

  # Hash the password before storing
  def dump(val) do
    {:ok, hash_pw(val)}
  end

  # Just return the value if requested
  def load(val) do
    {:ok, val}
  end

  # Unused, but still required to be defined
  def embed(_), do: :self

  # Invoke Argon2 to hash the password
  def hash_pw(val) do
    Argon2.Base.hash_password(to_string(val), Argon2.gen_salt(), [{:argon2_type, 2}])
  end

  # Compare pw and hash for equivalence
  def verify_pw(pw, hash) do
    Argon2.verify_pass(pw, hash)
  end
end
