defmodule Aoc.Day04 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.split("\n\n")
    |> Enum.map(fn pline ->
      String.replace(pline, "\n", " ")
      |> String.trim()
      |> String.split(" ")
    end)
    |> Enum.map(&build_passport/1)
  end

  @doc """
  ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
  byr:1937 iyr:2017 cid:147 hgt:183cm

  iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
  hcl:#cfa07d byr:1929

  hcl:#ae17e1 iyr:2013
  eyr:2024
  ecl:brn pid:760753108 byr:1931
  hgt:179cm

  hcl:#cfa07d eyr:2025 pid:166559648
  iyr:2011 ecl:brn hgt:59in
  """
  def p1(input) do
    input
    |> Enum.map(&Passport.minimal_changeset(%Passport{}, &1))
    |> Enum.map(fn changeset -> changeset.valid? end)
    |> Enum.filter(&(&1 == true))
    |> Enum.count()
  end

  def p2(input) do
    input
    |> Enum.map(&Passport.full_changeset(%Passport{}, &1))
    |> Enum.map(fn changeset -> changeset.valid? end)
    |> Enum.filter(&(&1 == true))
    |> Enum.count()
  end

  def build_passport(string_passport) do
    string_passport
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(fn [k, v] -> {k, v} end)
    |> Map.new()
  end
end
