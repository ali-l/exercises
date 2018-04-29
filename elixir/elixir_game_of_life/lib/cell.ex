defmodule Cell do
  use GenServer
  @alive "█"
  @dead ""

  def start_link(index) do
    GenServer.start_link(__MODULE__, %{status: @dead, neighbour_count: 0, index: index})
  end

  def make_alive(index, pids) do
    Enum.each(pids, &GenServer.cast(&1, {:alive, index}))
  end

  def make_dead(index, pids) do
    Enum.each(pids, &GenServer.cast(&1, {:dead, index}))
  end

  def simulate_generation(cells) do
    cells
    |> Enum.map(&Task.async(fn -> GenServer.call(&1, :generation) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.with_index
    |> Enum.map(&increment_index/1)
    |> Enum.each(&broadcast_change(cells, &1))
  end

  def increment_index({message, index}) do
    {message, index + 1}
  end

  def broadcast_change(cells, {:alive, index}) do
    make_alive(index, cells)
  end

  def broadcast_change(cells, {:dead, index}) do
    make_dead(index, cells)
  end

  def broadcast_change(_cells, {:no_change, _index}) do
    # Do nothing
  end

  def print(pids) do
    Enum.map(pids, &GenServer.call(&1, :print))
    |> Enum.chunk(GameOfLife.row_length)
    |> Enum.each(&print_row/1)
  end

  def print_row(row) do
    IO.puts Enum.reduce(row, "", &("#{&2} #{&1}"))
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  # Server (callbacks)

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:print, _from, state) do
    {:reply, state.status, state}
  end

  def handle_call(:generation, _from, state = %{status: @dead, neighbour_count: 3}) do
    {:reply, :alive, state}
  end

  def handle_call(:generation, _from, state = %{status: @alive, neighbour_count: n}) when n > 3 do
    {:reply, :dead, state}
  end

  def handle_call(:generation, _from, state = %{status: @alive, neighbour_count: n}) when n < 2 do
    {:reply, :dead, state}
  end

  def handle_call(:generation, _from, state) do
    {:reply, :no_change, state}
  end

  def handle_cast({:alive, index}, state) do
    cond do
       state.index == index ->
         {:noreply, Map.put(state, :status, @alive)}
       neighbour?(state.index, index) ->
         {:noreply, Map.update!(state, :neighbour_count, &(&1 + 1))}
       true ->
         {:noreply, state}
    end
  end

  def handle_cast({:dead, index}, state) do
    cond do
       state.index == index ->
         {:noreply, Map.put(state, :status, @dead)}
       neighbour?(state.index, index) ->
         {:noreply, Map.update!(state, :neighbour_count, &(&1 - 1))}
       true ->
         {:noreply, state}
    end
  end

  defp neighbour?(cell_index, message_index) do
    [cell_index - GameOfLife.row_length,
    cell_index + GameOfLife.row_length]
    |> conditional_merge(rem(cell_index, GameOfLife.row_length) != 1, [cell_index - 1, cell_index - 1 - GameOfLife.row_length, cell_index - 1 + GameOfLife.row_length])
    |> conditional_merge(rem(cell_index, GameOfLife.row_length) != 0, [cell_index + 1, cell_index + 1 - GameOfLife.row_length, cell_index + 1 + GameOfLife.row_length])
    |> Enum.any?(&(&1 == message_index))
  end

  defp conditional_merge(inital, true, merge) do
    [inital | merge]
    |> List.flatten
  end

  defp conditional_merge(inital, false, _) do
    inital
  end
end
