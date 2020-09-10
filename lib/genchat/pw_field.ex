# Ecto Data Type for automatically hashing passwords with the Argon2
# algorithm

defmodule Genchat.PasswordField do
  def hash_pw(val) do
    Argon2.Base.hash_password(to_string(val), Argon2.gen_salt(), [{:argon2_type, 2}])
  end
end
