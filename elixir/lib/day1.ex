defmodule Day1 do
  @moduledoc """
  Documentation for Day1.
  """

  @doc """
  Help Santa.

  ## Examples

      iex> Day1.calculateFuel(14,0)
      2

      iex> Day1.calculateFuel(1969,0)
      966

      iex> Day1.calculateFuel(100756,0)
      50346

  """
  def helpSanta do
    File.cwd! <> "/day1input.txt"
    |> File.read!
    |> String.split("\n")
    |> Enum.filter(fn(s)-> String.length(s) > 0 end)
    |> Enum.map(fn(m) ->
      String.to_integer(m)
      |> calculateFuel(0)
    end)
    |> Enum.sum
  end

  def calculateFuel(mass, total) when mass <= 0 do
    total
  end

  def calculateFuel(mass, total) do
    fuel = mass
      |> Integer.floor_div(3)
      |> Kernel.-(2)
      |> max(0)
    #IO.inspect(fuel)
    calculateFuel(fuel, fuel+total)
  end
end
