# Abstracted error handling that is referenced in the Guardian pipeline
# module definiton.

defmodule Genchat.UserManager.ErrorHandler do
  import Plug.Conn
  @behaviour Guardian.Plug.ErrorHandler

  # This line makes it obvious to developers and the compiler that this
  # definition is actually a callback, used elsewhere.
  @impl Guardian.Plug.ErrorHandler

  # If there's a problem authenticating, send an HTTP 401 error
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(401, body)
  end
end
