require_relative 'input'

class Day22
  def initialize(input)
    @garden = GardenMap.new(input)
  end

  def part_one(steps)
    @garden.find_all_tiles steps
  end

  def part_two(steps)
    @garden.find_all_tiles steps, true
  end
end
