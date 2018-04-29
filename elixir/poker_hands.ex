defmodule PokerHands do
  defmacrop straight?(v1, v2, v3, v4, v5) do
    quote do: unquote(v2) == unquote(v1) - 1 and unquote(v3) == unquote(v1) - 2 and unquote(v4) == unquote(v1) - 3 and unquote(v5) == unquote(v1) - 4
  end

  def pair_score, do: 100
  def two_pair_score, do: 200
  def triple_score, do: 300
  def straight_score, do: 400
  def full_house_score, do: 500
  def quadruple_score, do: 600

  def score(hand), do: hand |> generate_stats |> _score

  defp _score([{3, value1}, {2, value2} | _]), do: full_house_score + value1 * 3 + value2 * 2
  defp _score([{2, value1}, {2, value2} | _]), do: two_pair_score + value1 * 2 + value2 * 2
  defp _score([{2, value} | _]), do: pair_score + value * 2
  defp _score([{3, value} | _]), do: triple_score + value * 3
  defp _score([{4, value} | _]), do: quadruple_score + value * 4
  defp _score([{_, v1}, {_, v2}, {_, v3}, {_, v4}, {_, v5}]) when straight?(v1, v2, v3, v4, v5), do: straight_score + v1 + v2 + v3 + v4 + v5
  defp _score([{_, value} | _]), do: value

  defp generate_stats(hand) do
    hand
    |> Enum.group_by(&(&1))
    |> Enum.map(&({&1 |> elem(1) |> length, elem(&1, 0)}))
    |> Enum.sort(&(elem(&1, 0) > elem(&2, 0)))
  end
end
