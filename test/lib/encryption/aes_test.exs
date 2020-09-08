defmodule Encryption.AESTest do
  use ExUnit.Case
  alias Encryption.AES

  test "encrypt/1 includes initialization vector in return values" do
    <<init_vec::binary-16, cipher::binary>> = AES.encrypt("test string")

    assert String.length(init_vec) != 0
    assert String.length(cipher) != 0
    assert is_binary(cipher)
  end
end
