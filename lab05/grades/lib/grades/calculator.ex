defmodule Grades.Calculator do
  @moduledoc """
  Calcule le pourcentage, la note numerique (echelle sur 10, style
  Universite d'Ottawa) et la lettre a partir des devoirs, labos, intra
  et final d'un(e) etudiant(e).

  Ponderation:
    Devoirs (homework)  20%
    Labos               20%
    Intra (midterm)     30%
    Final               30%

  Reprend la logique developpee pour l'assignment #2 (calcul de note),
  branchee ici a la place du stub temporaire.
  """

  @hw_weight 0.20
  @lab_weight 0.20
  @midterm_weight 0.30
  @final_weight 0.30

  def percentage_grade(grades) do
    grades
    |> compute_percentage()
    |> Float.round(1)
    |> format_percentage()
  end

  def numeric_grade(grades) do
    grades
    |> compute_percentage()
    |> percentage_to_numeric()
  end

  def letter_grade(grades) do
    grades
    |> compute_percentage()
    |> percentage_to_letter()
  end

  defp compute_percentage(grades) do
    hw = average(grades[:homework]) * @hw_weight
    labs = average(grades[:labs]) * @lab_weight
    midterm = to_number(grades[:midterm]) * @midterm_weight
    final = to_number(grades[:final]) * @final_weight

    hw + labs + midterm + final
  end

  defp format_percentage(pct), do: "#{pct}%"

  defp average(nil), do: 0.0
  defp average([]), do: 0.0

  defp average(list) do
    values = Enum.map(list, &to_number/1)
    Enum.sum(values) / length(values)
  end

  defp to_number(nil), do: 0.0
  defp to_number(""), do: 0.0
  defp to_number(value) when is_number(value), do: value * 1.0

  defp to_number(value) when is_binary(value) do
    case Float.parse(value) do
      {num, _} -> num
      :error -> 0.0
    end
  end

  defp percentage_to_numeric(pct) when pct >= 90, do: 10
  defp percentage_to_numeric(pct) when pct >= 85, do: 9
  defp percentage_to_numeric(pct) when pct >= 80, do: 8
  defp percentage_to_numeric(pct) when pct >= 77, do: 7
  defp percentage_to_numeric(pct) when pct >= 73, do: 6
  defp percentage_to_numeric(pct) when pct >= 70, do: 5
  defp percentage_to_numeric(pct) when pct >= 67, do: 4
  defp percentage_to_numeric(pct) when pct >= 63, do: 3
  defp percentage_to_numeric(pct) when pct >= 60, do: 2
  defp percentage_to_numeric(pct) when pct >= 57, do: 1.5
  defp percentage_to_numeric(pct) when pct >= 53, do: 1
  defp percentage_to_numeric(pct) when pct >= 50, do: 0.5
  defp percentage_to_numeric(_), do: 0

  defp percentage_to_letter(pct) when pct >= 90, do: "A+"
  defp percentage_to_letter(pct) when pct >= 85, do: "A"
  defp percentage_to_letter(pct) when pct >= 80, do: "A-"
  defp percentage_to_letter(pct) when pct >= 77, do: "B+"
  defp percentage_to_letter(pct) when pct >= 73, do: "B"
  defp percentage_to_letter(pct) when pct >= 70, do: "B-"
  defp percentage_to_letter(pct) when pct >= 67, do: "C+"
  defp percentage_to_letter(pct) when pct >= 63, do: "C"
  defp percentage_to_letter(pct) when pct >= 60, do: "C-"
  defp percentage_to_letter(pct) when pct >= 57, do: "D+"
  defp percentage_to_letter(pct) when pct >= 53, do: "D"
  defp percentage_to_letter(pct) when pct >= 50, do: "D-"
  defp percentage_to_letter(_), do: "F"
end
