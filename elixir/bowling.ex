defmodule Bowling do
  def score(frames, points \\ 0)
  def score([], points),                               do: points
  def score([frame], points),                          do: score([], points + Enum.sum(frame))
  def score([[10] | rest], points),                    do: score(rest, points + 10 + sum_next_rolls(rest, 2))
  def score([[a, b] | rest], points) when a + b == 10, do: score(rest, points + a + b + sum_next_rolls(rest, 1))
  def score([frame | rest], points),                   do: score(rest, points + Enum.sum(frame))

  defp sum_next_rolls(frames, n), do: frames |> List.flatten |> Enum.take(n) |> Enum.sum
end
