defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "parameter mode: addition, immediate, immediate, add 100 to -1, store in position 4" do
    opCode =
      [1101,100,-1,4,0]
      |> Apex.ap
      |> Day5.process_code
      |> Apex.ap

    assert Enum.at(opCode, 4) == 99

  end

end
