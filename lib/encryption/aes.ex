# Encryption methods for the app will be defined here.
# Author: Cody Welsh <codyw at protonmail dot com>
# (For Genity)
#
# This module definition is essentially an amalgamation of various
# resources on encryption within Elixir/Phoenix.

defmodule Encryption.AES do
  @aad "AES256GCM"

  # Base encryption function for text
  # (encrypt/1)
  def encrypt(text) do
    # Random initialization vector
    init_vec = :crypto.strong_rand_bytes(16)

    # TODO: Implement get_key/0 module def
    # Gets the most recent key in a rotation of keys

    # Encrypt the text; return cipher, cipher tag
    {cipher, tag} =
      :crypto.block_encrypt(
        :aes_gcm,
        encr_key,
        init_vec,
        {
          @aad,
          to_string(text),
          16
        }
      )

    iv <> tag <> cipher
  end

  # get_key/0
  defp get_key do
    get_key_id()
    |> get_key
  end

  # get_key/1
  # Fetch a key based on its id
  defp get_key(id) do
    encr_keys()
    |> Enum.at(id)
  end

  # get_key/1
  # Get an index corresponding to the latest key in our n-key rotation
  defp get_key_id do
    Enum.count(encr_keys()) - 1
  end

  # encr_keys/0
  # "Application" is an Erlang library definition, and in this case will
  # allow us to retrieve an encryption key from the app environment
  defp encr_keys do
    Application.get_env
    (:encryption, Encryption.AES)[:keys]
  end
end
