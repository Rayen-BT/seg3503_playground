defmodule Grades.Calculator do
  @moduledoc """
  STUB - temporaire.

  Le module reel n'est pas encore implemente. On retourne des valeurs
  fixes uniquement pour empecher GradesWeb.PageLive de planter quand on
  clique sur "Calculate". Voir les observations dans le README.
  """

  def percentage_grade(_grades), do: "75.0%"
  def numeric_grade(_grades), do: 6
  def letter_grade(_grades), do: "B"
end
