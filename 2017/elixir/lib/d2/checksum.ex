defmodule Advent2016.Day2 do
  def solution do
    File.read!('./lib/d2/input')
    |> fileprep()
    |> map_row_diff()
    |> Enum.sum()
  end

  defp fileprep(file_input) do
    file_input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x, "\t") |> Enum.map(&String.to_integer(&1)) end)
  end

  defp map_row_diff(row) do
    row
    |> Enum.map(fn row_array -> rowdiff(row_array) end)
  end

  defp rowdiff(row) do
    Enum.max(row) - Enum.min(row)
  end
end
