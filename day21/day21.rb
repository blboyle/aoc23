require_relative 'input'

class Day21
  def initialize(input)
    @garden = GardenMap.new(input)
  end

  def part_one steps
    # p "one"
    @garden.find_all_tiles steps
  end


  def part_two
  end
end


class GardenMap
  def initialize input
    map = input.split("\n").reject{|item| item == ""}.map do |row|
      row.split("")
    end

    height = map.length
    width = map[0].length

    @map_dimensions = [height, width]
    @starting = find_starting map
    @found_tiles = {}
    @tracking = {}

    make_rock_locations map

  end

  def find_all_tiles steps
    # puts "\n\n"
    count = 0

    location = @starting
    # @max_step = steps - 1

    test_steps = 2

    @max_step = test_steps - 1
    # @max_step =

    next_step(location, 0)

    # p "hi"
    # p @found_tiles

    @found_tiles.keys.each do |key|
      # p @found_tiles[key]
      count += @found_tiles[key].length
    end

    p @tracking

    count
  end

  private

DIRECTIONS = ["N","S","E","W"]

  def next_step(location, step)

    p "next step #{location} #{step}/#{@max_step}"

    path = []
    depth = ""
    step.times do
      depth += "---"
    end

    return unless step <= @max_step

    # puts "\n"

    # p "checking if #{location} #{@rock_locations[location[0]].include? location[1]}"
    # p "step #{step}"
    # puts "\n#{depth} location #{location} step #{step}"
    @found_tiles[location[0]] ||= []
    @found_tiles[location[0]].delete(location[1])


    north = location[0] - 1 >= 0 ? [location[0]- 1, location[1]] : nil
    south = location[0] + 1 < @map_dimensions[0] ? [location[0]+ 1, location[1]] :  nil
    east = location[1] + 1 < @map_dimensions[1] ? [location[0], location[1]+ 1] : nil
    west = location[1] - 1 >= 0 ? [location[0], location[1]- 1] : nil

    # p "#{location} n#{north} e#{east} s#{south} w#{west}"

    step += 1


    p 'returning location' if step == @max_step
    return location if step == @max_step

    key = "#{location.join("-")}-#{step}"

    p 'returning tracker'  if @tracking[key]
    return @tracking[key] if @tracking[key]

    [north,south,east,west].each_with_index do |direction, i|

      next unless direction
#
      # p "direction #{direction}"

      is_rock = @rock_locations[direction[0]] && @rock_locations[direction[0]].include?(direction[1])
      is_tile = @found_tiles[direction[0]] && @found_tiles[direction[0]].include?(direction[1])

      unless is_rock
        unless is_tile
          @found_tiles[direction[0]] ||= []
          @found_tiles[direction[0]].push direction[1]
        end
        # p @found_tiles
        path.push next_step(direction, step) if step <= @max_step
      end

    end

    p "adding path to tracker #{path}"
    @tracking[key] = path

    path

  end

  def find_starting map
    start = []
    map.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell == "S"
          start = [i, j]
        end
      end
    end
    start
  end

  def make_rock_locations map
    @rock_locations = {}

    map.each_with_index do |row, i|
      row.each_with_index do |cell,j|
        if cell == "#"
          @rock_locations[i] ||= []
          @rock_locations[i].push j
        end
      end
    end

  end
end
