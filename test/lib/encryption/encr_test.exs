# Test that our Ecto.Type EncryptedField acts as we want it to

defmodule GenChat.EncryptedFieldTest do
  use ExUnit.Case
  use Genchat.DataCase
  alias Genchat.{EncryptedField, User, Repo}

  @u_name "Some Guy"
  @u_name_encr EncryptedField.dump(@u_name)
  @u_email "some@guy.com"

  @u_sample %{
    name: "Cody Welsh",
    email: "cody@cody.xyz",
    password: "notagoodpw"
  }

  describe "When data passes through EncryptedField" do
    setup do
      new_user = Repo.insert!(User.changeset(%User{}, @u_sample))
      user_db = User |> Repo.one!()
      {:ok, user: new_user, user_db: user_db}
    end

    test "encrypted data is not equal to unencrypted data" do
      assert !(@u_name == @u_name_encr)
    end

    test "passwords are not kept in plaintext", %{user: user, user_db: user_db} do
      assert user_db.password != EncryptedField.dump(user.password)
    end

    test "arbitrary encrypted text can be decrypted", %{user: user} do
      assert @u_sample.name == EncryptedField.load(user.name)
    end
  end
end
