defmodule Day5 do
  @moduledoc """
  Documentation for Day5.

  """

  @doc """
  Day5

  ## Examples

      iex> Day5.process_code([1,9,10,3,2,3,11,0,99,30,40,50], 0)
      3500

      iex> Day5.process_code([1,0,0,0,99], 0)
      2

      iex> Day5.process_code([2,3,0,3,99], 0)
      2

      iex> Day5.process_code([3,5,4,5,99,0])
      5

  """
  def part2 do
    noun = 0..99
    verb = 0..99
    noun
    |> Enum.each(fn n ->
      verb
      |> Enum.each(fn v->
        spawn(Day2, :intcode, [n,v])
      end)
    end)

  end

  def part1 do
    intcode(12,2)
  end

  def intcode(noun, verb) do
    opCodes =
      File.cwd!
      |> Path.join("day5input.txt")
      |> File.read!()
      |> String.replace("\r\n", "")
      |> String.split(",")
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(&String.to_integer(&1))

    opCodes = List.replace_at(opCodes,1,noun)
    opCodes = List.replace_at(opCodes,2,verb)

    ans = process_code(opCodes, opCodes)

    if(ans == 19690720) do
      IO.puts("#{noun} and #{verb} make 19690720!  #{noun*100+verb}")
    end
    ans
  end

  def process_code(opCodes, [1, offset1, offset2, destOffset | rest]) do
    num1 = Enum.fetch!(opCodes, offset1)
    num2 = Enum.fetch!(opCodes, offset2)
    opCodes
    |> List.replace_at(destOffset, num1 + num2)
    |> process_code(rest)
  end

  def process_code(opCodes, [2, offset1, offset2, destOffset | rest]) do
    num1 = Enum.fetch!(opCodes, offset1)
    num2 = Enum.fetch!(opCodes, offset2)
    opCodes
    |> List.replace_at(destOffset, num1 * num2)
    |> process_code(rest)
  end

  def process_code(opCodes, [3, num1 | rest]) do
    opCodes
    |> List.replace_at(num1, num1)
    |> process_code(rest)
  end

  def process_code(opCodes, [4, num1 | rest]) do
    IO.puts("opCode 4 value: #{num1}")
    opCodes
    |> process_code(rest)
  end

  def process_code(opCodes, [99 | _rest]) do
    Enum.fetch!(opCodes, 0)
  end

end
