# This defines the Guardian library implementation module that is used
# for proceeding user token requests.

defmodule Genchat.UserManager.Guardian do
  use Guardian, otp_app: :genchat

  alias Genchat.UserManager

  # Encode a user into a token
  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  # Reverse the operation of subject_for_token/2
  def resource_from_claims(%{"subj" => id}) do
    user = UserManager.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
