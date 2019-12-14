defmodule Day4 do
  @moduledoc """
  def runner do

    counter = spawn do_counter(self(), 0)

    biginningNumbner..endingNumber
    |> Enum.each
      spawn try [number, counterPid]

    receive do
      {:howmany, count} -> IO.puts("There are #{count} many working possibilities")
  end

  def do_counter(supervisor, numWorked) do
    recieve do
      {:worked} -> do_counter(supervisor, numWorked+1)
      {:howMany} -> send supervisor {:howmany, numWorked}
    end
    do_counter(supervisor, numWorked)
  end

  def try(number, counterPid) do
    if isValid(number) do
      send counterPid {:worked}
    end
  end
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day4.hello()
      :world

  """
  def hello do
    :world
  end
end
