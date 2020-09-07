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

    # Fetch the key and its id using the function chain below
    encr_key = get_key()
    id = get_id()

    # TODO: Implement get_key/0 module def
    # Gets the most recent key in a rotation of keys

    # Encrypt the text; return cipher, cipher tag, typed id, vector
    {cipher, tag} =
      :crypto.block_encrypt(
        :aes_gcm,
        encr_key,
        init_vec,
        {@aad, to_string(text), 16}
      )

    # Concat/return all the data we expect
    init_vec <>
      tag <>
      <<id::unsigned-big-integer-32>> <>
      cipher
  end

  # get_key/0
  defp get_key do
    get_id()
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
  defp get_id do
    Enum.count(encr_keys()) - 1
  end

  # encr_keys/0
  # "Application" is an Erlang library definition, and in this case will
  # allow us to retrieve an encryption key from the app environment
  defp encr_keys do
    Application.get_env(:encryption, Encryption.AES)[:keys]
  end

  # decrypt/1
  # Just performs the reverse operation compared to encrypt/1.
  def decrypt(cipher) do
    # If you're wondering what this syntax means, Elixir has an
    # interesting concept of "pattern matching" that is based on
    # comparison of each side of a given equation (as in math).
    # https://elixir-lang.org/getting-started/pattern-matching.html
    # (<<a::b>> means "represent a in binary format b".)
    iv_b = <<init_vec::binary-16>>
    t = <<tag::binary-16>>
    id = <<id::unsigned-big-integer-32>>
    c = <<cipher::binary>>

    # Concat and pattern match our data to ciphertext
    iv_b <> t <> id <> c = cipher

    :crypto.block_decrypt(:aes_gcm, get_key(id), init_vec, {@aad, cipher, tag})
  end
end
