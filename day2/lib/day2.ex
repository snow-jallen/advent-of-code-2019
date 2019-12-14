defmodule Day2 do
  @moduledoc """
  Documentation for Day2.  Alt+Q - that's the secret. :)  This is some long
  documentation.  I'm supposed to be able to just press a key and get this to
  wrap at just the right line length. Alt+Q - that's the secret. :)

  Input file:
  1, 0, 0, 3,
  1, 1, 2, 3,
  1, 3, 4, 3,
  1, 5, 0, 3,
  2, 13, 1, 19,
  1, 19, 10, 23,
  2, 10, 23, 27,
  1, 27, 6, 31,
  1, 13, 31, 35,
  1, 13, 35, 39,
  1, 39, 10, 43,
  2, 43, 13, 47,
  1, 47, 9, 51,
  2, 51, 13, 55,
  1, 5, 55, 59,
  2, 59, 9, 63,
  1, 13, 63, 67,
  2, 13, 67, 71,
  1, 71, 5, 75,
  2, 75, 13, 79,
  1, 79, 6, 83,
  1, 83, 5, 87,
  2, 87, 6, 91,
  1, 5, 91, 95,
  1, 95, 13, 99,
  2, 99, 6, 103,
  1, 5, 103, 107,
  1, 107, 9, 111,
  2, 6, 111, 115,
  1, 5, 115, 119,
  1, 119, 2, 123,
  1, 6, 123, 0,
  99, 2, 14, 0,
  0
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day2.processCode([1,9,10,3,2,3,11,0,99,30,40,50], 0)
      3500

      iex> Day2.processCode([1,0,0,0,99], 0)
      2

      iex> Day2.processCode([2,3,0,3,99], 0)
      2

      iex> 1+1
      2

  """
  def intcode do
    opCodes =
      (File.cwd!() <> "/input.txt")
      |> File.read!()
      |> String.replace("\n", "")
      |> IO.inspect()
      |> String.split(",")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      # |> Enum.take(1)
      |> Enum.map(fn s -> String.to_integer(s) end)
      |> IO.inspect()
      |> Apex.ap

    processCode(opCodes, 0)
  end

  def processCode(opCodes, offset) do
    Enum.slice(opCodes,offset,4) |> IO.inspect
    IO.puts("Processing opCodes starting at #{offset}")
    opCode = Enum.fetch!(opCodes, offset)

    case opCode do
      1 -> add(opCodes, offset)
      2 -> multiply(opCodes, offset)
      99 -> Enum.fetch!(opCodes, 0)
    end
  end

  def add(opCodes, offset) do
    num1Offset = Enum.fetch!(opCodes, offset + 1)
    num2Offset = Enum.fetch!(opCodes, offset + 2)
    destOffset = Enum.fetch!(opCodes, offset + 3)
    num1 = Enum.fetch!(opCodes, num1Offset)
    num2 = Enum.fetch!(opCodes, num2Offset)

    IO.inspect(opCodes)
    IO.puts("Adding #{num1} and #{num2} into position #{destOffset}")
    opCodes = List.replace_at(opCodes, destOffset, num1 + num2)
    IO.inspect(opCodes)

    processCode(opCodes, offset + 4)
  end

  def multiply(opCodes, offset) do
    num1Offset = Enum.fetch!(opCodes, offset + 1)
    num2Offset = Enum.fetch!(opCodes, offset + 2)
    destOffset = Enum.fetch!(opCodes, offset + 3)
    num1 = Enum.fetch!(opCodes, num1Offset)
    num2 = Enum.fetch!(opCodes, num2Offset)

    IO.inspect(opCodes)
    IO.puts("Multiplying #{num1} and #{num2} into position #{destOffset}")
    opCodes = List.replace_at(opCodes, destOffset, num1 * num2)
    IO.inspect(opCodes)

    processCode(opCodes, offset + 4)
  end
end
