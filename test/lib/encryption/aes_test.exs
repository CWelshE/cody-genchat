defmodule Genchat.AESTest do
  use ExUnit.Case
  alias Genchat.AES

  @same "this is the same string"
  @same_cryp @same |> AES.encrypt()
  @keys Application.get_env(:genchat, Genchat.AES)[:keys]

  test "encrypt/1 includes initialization vector in return values" do
    <<init_vec::binary-16, cipher::binary>> = AES.encrypt("test string")

    assert String.length(init_vec) != 0
    assert String.length(cipher) != 0
    assert is_binary(cipher)
  end

  test "encrypt/1 produces unique output with each invocation" do
    assert AES.encrypt(@same) != AES.encrypt(@same)
  end

  test "decrypt/1 can decipher encrypt/1 output" do
    assert @same |> AES.encrypt() |> AES.decrypt() == @same
  end

  test "decrypt/1 can decipher encrypt/1 after appending new keys" do
    # Add a random key generated from Erlang
    Application.put_env(:genchat, Genchat.AES, keys: @keys ++ [:crypto.strong_rand_bytes(32)])

    assert @same == @same_cryp |> AES.decrypt()

    # Restore the pre-test state
    Application.put_env(:genchat, Genchat.AES, keys: @keys)
  end
end
