# Encryption methods for the app will be defined here.
# Author: Cody Welsh <codyw at protonmail dot com>
# (For Genity)
#
# This module definition is essentially an amalgamation of various
# resources on encryption within Elixir/Phoenix.

defmodule Encryption.AES do
  @aad "AES256GCM"

  # Base encryption function for text
  def encrypt(text) do
    # Random initialization vector
    init_vec = :crypto.strong_rand_bytes(16)

    # TODO: Implement get_key/0 module def
    encr_key = get_key()

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
end
