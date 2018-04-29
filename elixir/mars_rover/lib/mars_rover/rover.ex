defmodule MarsRover.Rover do
  @enforce_keys [:x, :y, :direction]
  defstruct [:x, :y, :direction]
  alias MarsRover.Rover

  def move(rover = %Rover{direction: :north}) do
    Map.put(rover, :y, rover.y + 1)
  end

  def move(rover = %Rover{direction: :south}) do
    Map.put(rover, :y, rover.y - 1)
  end

  def move(rover = %Rover{direction: :east}) do
    Map.put(rover, :y, rover.x + 1)
  end

  def move(rover = %Rover{direction: :west}) do
    Map.put(rover, :y, rover.x - 1)
  end
end
