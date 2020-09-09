defmodule Genchat.UserTest do
  use Genchat.DataCase
  alias Genchat.{User, Repo}

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
  end
end
