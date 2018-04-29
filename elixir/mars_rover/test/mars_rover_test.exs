defmodule MarsRoverTest do
  use ExUnit.Case
  alias MarsRover.{Rover, Plateau}


  describe "MarsRover.process/3" do
    test "with no instructions returns the rover" do
      rover = %Rover{x: 1, y: 1, direction: 0}
      plateau = %Plateau{width: 10, height: 10}
      assert MarsRover.process(rover, plateau, []) == rover
    end
  end
end
