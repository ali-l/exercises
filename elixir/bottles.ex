# From http://elixirgolf.com/articles/99-bottles-of-elixir/

defmodule Bottles do
  def countdown(n) do
    spawn fn ->
      print_current(n)
      print_next(n - 1)
      if n > 1, do: countdown(n - 1)
    end
  end

  defp print_current(n) do
    IO.puts "#{inspect self} #{n} bottle#{if n > 1, do: "s"} of Elixir on the wall, #{n} bottle#{if n > 1, do: "s"} of Elixir."
  end

  defp print_next(n) do
    IO.puts "#{if n > 0, do: "Take one down and pass it around", else: "Go code some more"}, #{if n > 0, do: n, else: 99} bottle#{if n > 1, do: "s"} of Elixir on the wall.\n"
  end
end

# Bottles.countdown(99)
