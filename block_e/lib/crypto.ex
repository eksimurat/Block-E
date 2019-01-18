defmodule Crypto do
  # Specify which fields to hash in a block
  @hash_fields [:data, :timestamp, :prev_hash]

  @doc "Calculate the hash of a block"
  def cal_hash(%{} = block) do
    block
    |> Map.take(@hash_fields)
    |> Poison.encode!()
    |> sha256
  end

  @doc "Call the cal_hash function and insert the calculated hash to the block"
  def insert_hash(%{} = block) do
    %{block | hash: cal_hash(block)}
  end

  # SHA256 calculation for the binary string
  defp sha256(binary) do
    :crypto.hash(:sha256, binary) |> Base.encode16()
  end
end
