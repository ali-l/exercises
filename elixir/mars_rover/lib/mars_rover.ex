defmodule MarsRover do
  def process(rover, plateau, []) do
    rover
  end

  def process(rover, plateau, [instruction | rest]) do
    
    process(rover, plateau, rest)
  end
end
