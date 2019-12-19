defmodule Day4 do
  @moduledoc """
  def runner do

    counter = spawn do_counter(self(), 0)

    biginningNumbner..endingNumber
    |> Enum.each
      spawn try [number, counterPid]

    receive do
      {:howmany, count} -> IO.puts("There are {count} many working possibilities")
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

  def runner(start,stop) do
    counterPid = spawn(Day4, :do_counter, [self(), 0])

    start..stop
    |> Enum.each(fn num -> spawn(Day4, :try, [num, counterPid]) end)

    receive do
      {:howMany, count} -> IO.puts("There are #{count} numbers that fit the rules")
      _ -> IO.puts("What sort of weird message was that?!")
    end
  end

  def do_counter(supervisor, numWorked) do
    IO.puts("do_counter called, current count is #{numWorked}!")
    receive do
      {:worked} -> do_counter(supervisor, numWorked+1)
      {:howMany} -> send(supervisor, {:howMany, numWorked})
    end
    do_counter(supervisor, numWorked)
  end

  def try(number, counterPid) do
    if(isValid(number)) do
      send(counterPid, {:worked})
    end
  end

  def isValid(number) do
    {:ok,number}
    |> isSixDigits
    |> twoAdjacentDigitsAreTheSame
    |> digitsNeverDecrease
    |> case do
      {:ok, _number} -> true
      _ -> false
    end
  end

  def isSixDigits({:ok, number}) do
    length = to_string(number)
    |> String.length
    case length do
      6 -> {:ok, number}
      _ -> {:error, number}
    end
  end
  def isSixDigits({:error,opts}), do: {:error, opts}

  def twoAdjacentDigitsAreTheSame({:ok,number}) do
    str = to_string(number)
    str
      |> String.graphemes
      |> Enum.map(fn char ->
        String.contains?(str, char<>char) && !String.contains?(str, char<>char<>char)
      end)
      |> Enum.any?(fn item -> item == true end)
      |> case do
        true -> {:ok, number}
        _ -> {:error, number}
      end
  end
  def twoAdjacentDigitsAreTheSame({:error,number}), do: {:error, number}

  def digitsNeverDecrease({:ok,number}) do
    number
    |> to_string
    |> String.graphemes
    |> Enum.chunk_every(2,1,:discard)
    |> Enum.map(fn [x,y] -> x <= y end)
    |> Enum.all?(fn item -> item == true end)
    |> case do
      true -> {:ok, number}
      _ -> {:error, number}
    end
  end
  def digitsNeverDecrease({:error,number}), do: {:error,number}
end
