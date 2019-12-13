defmodule Day1 do
  @moduledoc """
  Documentation for Day1.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day1.hello()
      :world

  """
  def helpSanta do
    File.cwd! <> "/input.txt"
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
    IO.inspect(fuel)
    calculateFuel(fuel, fuel+total)
  end
end
