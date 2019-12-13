defmodule Day2 do
  @moduledoc """
  Documentation for Day2.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day2.processCode([1,9,10,3,2,3,11,0,99,30,40,50], 0)
      3500

  """
  def intcode do
    opCodes = File.cwd! <> "/input.txt"
    |> File.read!
    |> String.replace("\n","")
    #|> String.split("\n")
    |> String.split(",")
    |> Enum.filter(fn(s)->String.length(s) > 0 end)
    #|> Enum.take(1)
    |> Enum.map(fn(s)-> String.to_integer(s) end)
    |> IO.inspect

    processCode(opCodes, 0)
  end

  def processCode(opCodes, offset) do
    opCode = Enum.fetch!(opCodes,offset)
    case opCode do
      1 -> add(opCodes,offset)
      2 -> multiply(opCodes,offset)
      99 -> Enum.fetch!(opCodes,0)
    end
  end

  def add(opCodes, offset) do
    num1Offset = Enum.fetch!(opCodes,offset+1)
    num2Offset = Enum.fetch!(opCodes,offset+2)
    destOffset = Enum.fetch!(opCodes,offset+3)
    num1 = Enum.fetch!(opCodes, num1Offset)
    num2 = Enum.fetch!(opCodes, num2Offset)
    dest = Enum.fetch!(opCodes, destOffset)
    opCodes = List.replace_at(opCodes, dest, num1+num2)
    IO.puts("Adding #{num1} and #{num2} into position #{dest}")
    IO.inspect(opCodes)

    processCode(opCodes, offset+4)
  end

  def multiply(opCodes, offset) do
    num1Offset = Enum.fetch!(opCodes,offset+1)
    num2Offset = Enum.fetch!(opCodes,offset+2)
    destOffset = Enum.fetch!(opCodes,offset+3)
    num1 = Enum.fetch!(opCodes, num1Offset)
    num2 = Enum.fetch!(opCodes, num2Offset)
    dest = Enum.fetch!(opCodes, destOffset)
    opCodes = List.replace_at(opCodes, dest, num1*num2)
    IO.puts("Multiplying #{num1} and #{num2} into position #{dest}")
    IO.inspect(opCodes)

    processCode(opCodes, offset+4)
  end
end
