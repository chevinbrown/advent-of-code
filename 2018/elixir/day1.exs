defmodule Day1 do
  def sumtotal do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
    |> IO.puts()
  end
end

Day1.sumtotal()
