defmodule Blockchain do
  @moduledoc """
  Documentation for Blockchain.
  """

  @doc "Creates the genesis block"
  def initial do
    [Crypto.insert_hash(Block.genesis())]
  end

  @doc "Insert the given data as a new block to the Blockchain"
  def insert(blockchain, data) when is_list(blockchain) do
    %Block{hash: prev} = hd(blockchain)

    block =
      data
      |> Block.insert_block(prev)
      |> Crypto.insert_hash()

    [block | blockchain]
  end

  @doc "Validate the Blockchain"
  def valid?(blockchain) when is_list(blockchain) do
    genesis =
      Enum.reduce_while(blockchain, nil, fn prev, current ->
        cond do
          current == nil ->
            {:cont, prev}

          Block.valid?(current, prev) ->
            {:cont, prev}

          true ->
            {:halt, false}
        end
      end)

    if genesis, do: Block.valid?(genesis), else: false
  end
end
