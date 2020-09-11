# Test correct functionality of Argon2 hashing functions applied to user
# passwords in the Ecto Data Type

defmodule Genchat.PasswordFieldTest do
  use ExUnit.Case
  use Genchat.DataCase, async: true
  alias Genchat.{PasswordField, UserManager.User, Repo}

  @pw "correct horse battery staple"
  @pw_hash PasswordField.hash_pw(@pw)

  test "passwords are correctly hashed by Argon2" do
    assert Argon2.verify_pass(@pw, @pw_hash)
  end

  test "passwords are verified by PasswordField" do
    assert PasswordField.verify_pw(@pw, @pw_hash)
  end

  test "password verification fails in expected contexts" do
    assert !PasswordField.verify_pw("notcorrecthash", @pw_hash)
  end

  @u_sample %{
    name: "Cody Welsh",
    email: "cody@cody.xyz",
    password: "notagoodpw"
  }

  describe "When users store their password" do
    setup do
      new_user = Repo.insert!(User.changeset(%User{}, @u_sample))
      user_db = User |> Repo.one!()
      {:ok, user: new_user, user_db: user_db}
    end

    test "the password hash is stored", %{user_db: user_db} do
      hash = PasswordField.hash_pw(@u_sample.password)
      assert user_db.password_hash != hash
    end

    test "the password hash is different for the same text" do
      pwhash1 = PasswordField.hash_pw(@pw)
      pwhash2 = PasswordField.hash_pw(@pw)

      assert pwhash1 != pwhash2
    end
  end
end
