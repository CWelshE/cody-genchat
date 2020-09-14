# This pipeline instructs Guardian to supervise over session and header
# authentication, and load in users upon success.

defmodule Genchat.UserManager.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :genchat,
    error_handler: Genchat.UserManager.ErrorHandler,
    module: Genchat.UserManager.Guardian

  @claims %{"typ" => "access"}
  # Look for and validate session and/or header tokens.
  plug Guardian.Plug.VerifySession, claims: @claims
  plug Guardian.Plug.VerifyHeader, claims: @claims

  # If either of the above plugs succeeds, the user gets loaded.
  plug Guardian.Plug.LoadResource, allow_blank: true
end
