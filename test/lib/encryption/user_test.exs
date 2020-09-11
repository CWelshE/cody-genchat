defmodule Genchat.UserManager.UserTest do
  use Genchat.DataCase
  alias Genchat.{UserManager.User, Repo}

  @valid_req %{
    name: "Cody Welsh",
    email: "cody@email.com",
    password: "someunencryptedstr"
  }

  describe "Expected attributes are hashed" do
    setup do
      user = Repo.insert!(User.changeset(%User{}, @valid_req))
      {:ok, user: user, email: @valid_req.email}
    end

    test "New user emails create new email hashes", %{user: user} do
      assert user.email == user.email_hash
    end

    test "The hashed email is equivalent to the unhashed email", %{user: user} do
      user_db = User |> Repo.one!()
      assert user_db.email_hash == Genchat.HashField.hash(user.email)
    end
  end
end
