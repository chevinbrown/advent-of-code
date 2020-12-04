defmodule Passport do
  use Ecto.Schema
  import Ecto.Changeset

  # byr (Birth Year)
  # iyr (Issue Year)
  # eyr (Expiration Year)
  # hgt (Height)
  # hcl (Hair Color)
  # ecl (Eye Color)
  # pid (Passport ID)
  # cid (Country ID)
  embedded_schema do
    field(:byr, :integer)
    field(:iyr, :integer)
    field(:eyr, :integer)
    field(:hgt)
    field(:hcl)
    field(:ecl)
    field(:pid)
    field(:cid)
  end

  def minimal_changeset(passport, attrs) do
    passport
    |> cast(attrs, [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid])
    |> validate_required([:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid])
  end

  def full_changeset(passport, attrs) do
    passport
    |> cast(attrs, [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid])
    |> validate_required([:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid])
    |> validate_inclusion(:byr, 1920..2002)
    |> validate_inclusion(:iyr, 2010..2020)
    |> validate_inclusion(:eyr, 2020..2030)
    |> validate_height()
    # hair color, hex
    |> validate_format(:hcl, ~r/#[0-9a-fA-F]{6}/)
    |> validate_inclusion(:ecl, ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
    # passport-id
    |> validate_format(:pid, ~r/^\d{9}$/)
  end

  # hgt (Height) - a number followed by either cm or in:
  # If cm, the number must be at least 150 and at most 193.
  # If in, the number must be at least 59 and at most 76.
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  defp validate_height(changeset) do
    validate_change(changeset, :hgt, fn _current_field, value ->
      cond do
        String.contains?(value, "cm") ->
          hgt = String.trim(value, "cm") |> String.to_integer()

          if hgt in 150..193 do
            []
          else
            [{:hgt, "This is not a valid height"}]
          end

        String.contains?(value, "in") ->
          hgt = String.trim(value, "in") |> String.to_integer()

          if hgt in 59..76 do
            []
          else
            [{:hgt, "This is not a valid height"}]
          end

        true ->
          [{:hgt, "This is not a valid height"}]
      end
    end)
  end
end
