# From http://elixirgolf.com/articles/elixir-rock-paper-scissors/

defmodule RockPaperScissors do
  @letter_map %{1 => "r", 2 => "p", 3 => "s"}

  def play do
    cpu_moves = generate_cpu_moves
    player_moves = get_player_moves

    cpu_moves |> Enum.join |> IO.puts

    player_moves
    |> Enum.zip(cpu_moves)
    |> score_moves
    |> sum_scores
    |> endgame_message
    |> IO.puts
  end

  defp sum_scores(scores), do: scores |> Enum.reduce(0, &(&1 + &2))

  defp get_player_moves do
    "Enter 3 moves: " |> IO.gets |> String.strip |> String.split("", parts: 3)
  end

  defp endgame_message(score) when score < 0, do: "Lose"
  defp endgame_message(score) when score > 0, do: "Win"
  defp endgame_message(0), do: "Draw"

  defp get_score({"r", "s"}), do: 1
  defp get_score({"s", "p"}), do: 1
  defp get_score({"p", "r"}), do: 1
  defp get_score({m, m}), do: 0
  defp get_score(_), do: -1

  defp seed_random do
    << a :: 32, b :: 32, c :: 32 >> = :crypto.rand_bytes(12)
    :random.seed(a,b,c)
  end

  defp get_random_numbers do
    seed_random
    [:random.uniform(3), :random.uniform(3), :random.uniform(3)]
  end

  defp generate_cpu_moves do
    for n <- get_random_numbers, do: Map.fetch(@letter_map, n) |> elem(1)
  end

  defp score_moves(moves) do
    for {m1, m2} <- moves, do: get_score({m1, m2})
  end
end

# RockPaperScissors.play
