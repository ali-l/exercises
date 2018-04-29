defmodule GameOfLife do
  def row_length, do: 20

  def run(generations) do
    cells = initialize
    _run(cells, generations)
  end

  def _run(_, 0) do
    IO.puts "Finished"
  end

  def _run(cells, generations) do
    IO.puts "\e[H\e[2J"
    Cell.print(cells)
    # Process.sleep(50)
    Cell.simulate_generation(cells)
    _run(cells, generations - 1)
  end

  defp initialize	do
  	1..(row_length * row_length)
  	|> Enum.map(&Cell.start_link/1)
  	|> Enum.map(&elem(&1, 1))
    |> seed_cells
  end

  defp seed_cells(pids) do
    for _ <- 1..(row_length * 5), do: :rand.uniform(row_length * row_length) |> Cell.make_alive(pids)
    pids
  end
end
