# Test the UserManager submodule that handles a lot of the User model
# behavior.
defmodule Genchat.UserManagerTest do
  use Genchat.DataCase

  alias Genchat.UserManager

  describe "The UserManager def" do
    alias Genchat.UserManager.User
    alias Genchat.{PasswordField, HashField}

    @valid_attrs %{
      name: "some name",
      password: "some password",
      email: "some@email.com"
    }

    @update_attrs %{
      name: "some updated name"
    }

    @invalid_attrs %{
      name: nil,
      password: nil,
      email: nil
    }

    setup do
      user = Repo.insert!(User.changeset(%User{}, @valid_attrs))
      {:ok, user: user}
    end

    test "list_users/0 returns all users", %{user: user} do
      assert UserManager.list_users() == [UserManager.get_user!(user.id)]
    end

    test "get_user!/1 returns the user with given id", %{user: user} do
      assert UserManager.get_user!(user.id).name == user.name
    end

    test "create_user/1 with valid data creates a user" do
      new_user = %{
        name: "new person",
        email: "new@person.com",
        password: "verynew222"
      }

      created = UserManager.create_user(new_user)
      retrieved = UserManager.get_user!(created.id)

      assert created.id == retrieved.id
      assert created.name == retrieved.name
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert_raise Ecto.InvalidChangesetError, fn ->
        UserManager.create_user(@invalid_attrs)
      end
    end

    test "update_user/2 with valid data updates the user", %{user: user} do
      user_db = UserManager.get_user!(user.id)
      update = UserManager.update_user(user_db, @update_attrs)
      user_db_2 = UserManager.get_user!(user.id)

      assert user_db_2.name == "some updated name"
    end

    test "change_user/1 returns a user changeset", %{user: user} do
      user_db = UserManager.get_user!(user.id)
      assert %Ecto.Changeset{} = UserManager.change_user(user_db)
    end

    test "update_user/2 with invalid data returns error changeset", %{user: user} do
      assert_raise Ecto.InvalidChangesetError, fn ->
        user_db = UserManager.get_user!(user.id)
        UserManager.update_user(user_db, @invalid_attrs)
      end
    end

    test "delete_user/1 deletes the user", %{user: user} do
      assert {:ok, %User{}} = UserManager.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> UserManager.get_user!(user.id) end
    end
  end
end
