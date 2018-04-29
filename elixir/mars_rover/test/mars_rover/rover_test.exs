defmodule MarsRoverRoverTest do
  use ExUnit.Case
  alias MarsRover.Rover

  describe "MarsRover.Rover.move/1" do
    test "moves forward in the direction it is facing" do
      rover = %Rover{x: 1, y: 1, direction: :north}
      assert (rover = Rover.move(rover)) == Map.put(rover, :y, 2)
      assert Rover.move(rover) == Map.put(rover, :y, 3)
    end
  end
end
