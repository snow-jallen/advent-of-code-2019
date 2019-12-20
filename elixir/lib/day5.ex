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
      |> Enum.each(fn v ->
        spawn(Day2, :intcode, [n, v])
      end)
    end)
  end

  def part1 do
    intcode(12, 2)
  end

@doc """
3,225,
1,225,6,6,
1100,1,238,225,
104,0,
1101,61,45,225,
102,94,66,224,
101,-3854,224,224,
4,224,
102,8,223,223,
1001,224,7,224,
1,223,224,223,
1101,31,30,225,
1102,39,44,224,
1001,224,-1716,224,
4,224,
102,8,223,223,
1001,224,7,224,
1,224,223,223,
1101,92,41,225,
101,90,40,224,
1001,224,-120,224,
4,224,
102,8,223,223,
1001,224,1,224,
1,223,224,223,
1101,51,78,224,
101,-129,224,224,
4,224,
1002,223,8,223,
1001,224,6,224,
1,224,223,223,
1,170,13,224,
101,-140,224,224,
4,224,
102,8,223,223,
1001,224,4,224,
1,223,224,223,
1101,14,58,225,
1102,58,29,225,
1102,68,70,225,
1002,217,87,224,
101,-783,224,224,
4,224,
102,8,223,223,
101,2,224,224,
1,224,223,223,
1101,19,79,225,
1001,135,42,224,
1001,224,-56,224,
4,224,
102,8,223,223,
1001,224,6,224,
1,224,223,223,
2,139,144,224,
1001,224,-4060,224,
4,224,
102,8,223,223,
101,1,224,224,
1,223,224,223,
1102,9,51,225,
4,223,
99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,1008,677,226,224,102,2,223,223,1006,224,329,101,1,223,223,108,677,677,224,102,2,223,223,1005,224,344,101,1,223,223,107,677,677,224,1002,223,2,223,1005,224,359,101,1,223,223,1107,226,677,224,1002,223,2,223,1005,224,374,1001,223,1,223,1008,677,677,224,102,2,223,223,1006,224,389,1001,223,1,223,1007,677,677,224,1002,223,2,223,1006,224,404,1001,223,1,223,8,677,226,224,102,2,223,223,1005,224,419,1001,223,1,223,8,226,226,224,102,2,223,223,1006,224,434,101,1,223,223,1107,226,226,224,1002,223,2,223,1006,224,449,101,1,223,223,1107,677,226,224,102,2,223,223,1005,224,464,101,1,223,223,1108,226,226,224,102,2,223,223,1006,224,479,1001,223,1,223,7,677,677,224,1002,223,2,223,1006,224,494,101,1,223,223,7,677,226,224,102,2,223,223,1005,224,509,101,1,223,223,1108,226,677,224,1002,223,2,223,1006,224,524,101,1,223,223,8,226,677,224,1002,223,2,223,1005,224,539,101,1,223,223,1007,226,226,224,102,2,223,223,1006,224,554,1001,223,1,223,108,226,226,224,1002,223,2,223,1006,224,569,1001,223,1,223,1108,677,226,224,102,2,223,223,1005,224,584,101,1,223,223,108,226,677,224,102,2,223,223,1005,224,599,101,1,223,223,1007,226,677,224,102,2,223,223,1006,224,614,1001,223,1,223,1008,226,226,224,1002,223,2,223,1006,224,629,1001,223,1,223,107,226,226,224,1002,223,2,223,1006,224,644,101,1,223,223,7,226,677,224,102,2,223,223,1005,224,659,1001,223,1,223,107,677,226,224,102,2,223,223,1005,224,674,1001,223,1,223,4,223,99,226
"""
  def intcode(noun, verb) do
    opCodes =
      File.cwd!()
      |> Path.join("day5input.txt")
      |> File.read!()
      |> String.replace("\n", "")
      |> String.split(",")
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(&String.to_integer(&1))

    # opCodes = List.replace_at(opCodes, 1, noun)
    # opCodes = List.replace_at(opCodes, 2, verb)

    ans = start_instruction(opCodes, 0)

    if(ans == 19690720) do
      IO.puts("#{noun} and #{verb} make 19690720!  #{noun * 100 + verb}")
    end

    ans
  end

  def start_instruction(codes, offset) when length(codes) > offset do
    codes
    |> Enum.drop(offset)
    |> Enum.take(12)
    # |> IO.inspect(label: "Next 12, starting @ #{offset}")

    info = parse_instruction_info(codes, offset)

    codes
    |> do_instruction(offset, info)
    |> start_instruction(info[:next_offset])
  end

  def start_instruction(codes, _offset) do
    IO.puts("Nothing left to do...")
    Enum.fetch!(codes, 0)
  end

  def do_instruction(codes, _offset, info = %{:opcode => 1}) do
    # IO.puts("opcode 1 (addition): #{info[:val1]} + #{info[:val2]} into position #{info[:dest]}")
    codes
    |> List.replace_at(info[:dest], info[:val1] + info[:val2])
  end

  def do_instruction(codes, _offset, info = %{:opcode => 2}) do
    # IO.puts("opcode 2 (multiplication): #{info[:val1]} * #{info[:val2]} into position #{info[:dest]}")
    codes
    |> List.replace_at(info[:dest], info[:val1] * info[:val2])
  end

  def do_instruction(codes, offset, _info = %{:opcode => 3}) do
    val = Enum.fetch!(codes, offset + 1)
    newVal =
      IO.gets("opcode 3: Please enter a number for me to put into position #{val}\n")
      |> String.trim()
      |> String.to_integer()

    codes
    |> List.replace_at(val, newVal)
  end

  def do_instruction(codes, offset, _info = %{:opcode => 4}) do
    dest = Enum.fetch!(codes, offset + 1)
    val = Enum.fetch!(codes, dest)
    IO.puts("opcode 4: output @ position #{dest};  val=#{val}")
    codes
  end

  def do_instruction(codes, _offset, _info = %{:opcode => 99}) do
    IO.puts("opcode 99 - all done!")
    codes
  end

  def parse_instruction_info(codes, offset) do
    instruction = Enum.fetch!(codes, offset)

    info =
      %{}
      |> Map.put(:instruction, instruction)
      |> Map.put(:opcode, rem(instruction, 100))

    parse_instruction_info(codes, offset, info)
    # |> IO.inspect
  end

  def parse_instruction_info(codes, offset, info = %{:opcode => opcode})
      when opcode == 1 or opcode == 2 do
    # addition and multiplication have 3 parameters
    modes = div(info[:instruction], 100)
    param1Mode = rem(modes, 10)

    modes = div(modes, 10)
    param2Mode = rem(modes, 10)

    modes = div(modes, 10)
    param3Mode = rem(modes, 10)

    val1 = get_value(codes, offset + 1, param1Mode)
    val2 = get_value(codes, offset + 2, param2Mode)

    info
    |> Map.put(:param1Mode, param1Mode)
    |> Map.put(:param2Mode, param2Mode)
    |> Map.put(:param3Mode, param3Mode)
    |> Map.put(:param1Offset, offset + 1)
    |> Map.put(:param2Offset, offset + 2)
    |> Map.put(:val1, val1)
    |> Map.put(:val2, val2)
    |> Map.put(:dest, Enum.fetch!(codes, offset + 3))
    |> Map.put(:next_offset, offset + 4)
  end

  def parse_instruction_info(_codes, offset, info = %{:opcode => opcode})
      when opcode == 3 or opcode == 4 do
    info
    |> Map.put(:next_offset, offset + 2)
  end

  def parse_instruction_info(_codes, _offset, info = %{:opcode => opcode})
      when opcode == 99 do
    info
  end

  def get_value(codes, offset, _paramMode = 0) do
    arg = Enum.fetch!(codes, offset)
    # IO.puts("get_value codes[#{offset}] = #{arg}; codes[#{arg}] = #{Enum.fetch!(codes, arg)}")

    codes
    |> Enum.fetch!(arg)
  end

  def get_value(codes, offset, _paramMode = 1) do
    # IO.puts("get_value codes[#{offset}] = #{Enum.fetch!(codes, offset)}")
    Enum.fetch!(codes, offset)
  end
end
