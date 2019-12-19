defmodule Day2 do
  @moduledoc """
  Documentation for Day2.  Alt+Q - that's the secret. :)  This is some long
  documentation.  I'm supposed to be able to just press a key and get this to
  wrap at just the right line length. Alt+Q - that's the secret. :)

  """

  @doc """
  Day2

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
  def part2 do
    noun = 0..99
    verb = 0..99
    noun
    |> Enum.each(fn n ->
      verb
      |> Enum.each(fn v->
        #IO.puts("Spawning process for #{n}/#{v}")
        spawn(Day2, :intcode, [n,v])
      end)
    end)

  end

  def part1 do
    intcode(12,2)
  end

  def intcode(noun, verb) do
    opCodes =
      (File.cwd!() <> "/day2input.txt")
      |> File.read!()
      |> String.replace("\n", "")
      |> String.split(",")
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.map(fn s -> String.to_integer(s) end)

    opCodes = List.replace_at(opCodes,1,noun)
    opCodes = List.replace_at(opCodes,2,verb)

    ans = processCode(opCodes, 0)

    #IO.puts("With noun #{noun} and verb #{verb} answer is #{ans}")
    if(ans == 19690720) do
      IO.puts("#{noun} and #{verb} make 19690720!  #{noun*100+verb}")
    end
  end

  def processCode(opCodes, offset) do
    #Enum.slice(opCodes,offset,4) |> IO.inspect
    #IO.puts("Processing opCodes starting at #{offset}")
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

    #IO.inspect(opCodes)
    #IO.puts("Adding #{num1} and #{num2} into position #{destOffset}")
    opCodes = List.replace_at(opCodes, destOffset, num1 + num2)
    #IO.inspect(opCodes)

    processCode(opCodes, offset + 4)
  end

  def multiply(opCodes, offset) do
    num1Offset = Enum.fetch!(opCodes, offset + 1)
    num2Offset = Enum.fetch!(opCodes, offset + 2)
    destOffset = Enum.fetch!(opCodes, offset + 3)
    num1 = Enum.fetch!(opCodes, num1Offset)
    num2 = Enum.fetch!(opCodes, num2Offset)

    #IO.inspect(opCodes)
    #IO.puts("Multiplying #{num1} and #{num2} into position #{destOffset}")
    opCodes = List.replace_at(opCodes, destOffset, num1 * num2)
    #IO.inspect(opCodes)

    processCode(opCodes, offset + 4)
  end
end
