defmodule Block do
    defstruct [:data, :timestampt, :prev_hash, :hash]

    @doc "Build a new block for given data and previous hash"
    def insert_block(data, prev_hash) do
        %Block{
            data: data,
            prev_hash: prev_hash,
            timestampt: NaiveDateTime.utc_now
        }
    end

    @doc "Build the genesis block of the chain"   
    def genesis do
        %Block{
            data: nil,
            prev_hash: nil,
            timestampt: NaiveDateTime.utc_now
        }
    end


    @doc "Check if a block is valid"
    def valid?(%Block{} = block) do
        Crypto.cal_hash(block) == block.hash
    end

    def valid?(%Block{} = block, %Block{} = prev_block) do
        (block.prev_hash == prev_block.hash) && valid?(block)
    end
end