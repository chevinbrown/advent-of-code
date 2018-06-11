# 1122 produces a sum of 3 (1 + 2) because the first digit (1) matches the second digit and the third digit (2) matches the fourth digit.
# 1111 produces 4 because each digit (all 1) matches the next.
# 1234 produces 0 because no digit matches the next.
# 91212129 produces 9 because the only digit that matches the next one is the last digit, 9.
#
defmodule Advent2016.Day2 do
  @input = "./input"

  def parsefile do
    @input
    |> File.read!()
    |> String.trim()
    |> IO.puts()
  end
end
