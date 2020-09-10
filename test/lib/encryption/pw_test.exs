# Test correct functionality of Argon2 hashing functions applied to user
# passwords in the Ecto Data Type

defmodule Genchat.PasswordFieldTest do
  use ExUnit.Case
  alias Genchat.PasswordField
  @pw "correct horse battery staple"
  @pw_hash PasswordField.hash_pw(@pw)

  test "passwords are correctly hashed by Argon2" do
    assert Argon2.verify_pass(@pw, @pw_hash)
  end
end
