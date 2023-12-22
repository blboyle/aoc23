require_relative 'input'

class Day21
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

class GardenMap
  def initialize(input)
    map = input.split("\n").reject { |item| item == '' }.map do |row|
      row.split('')
    end

    height = map.length
    width = map[0].length

    @map_dimensions = [height, width]
    @starting = find_starting map
    @found_tiles = {}
    @tracking = {}

    make_rock_locations map
  end

  def find_all_tiles(steps, infinite = false)
    # puts "\n\n"
    count = 0

    location = @starting
    @max_step = steps

    # test_steps = 3

    # @max_step = test_steps - 1
    # @max_step =

    path = next_step(location, 0, infinite)

    # p path.uniq.sort

    path.uniq.length

    # p "hi"
    # p @found_tiles

    # @found_tiles.keys.each do |key|
    #   # p @found_tiles[key]
    #   count += @found_tiles[key].length
    # end

    # puts "\n"
    # p @tracking
  end

  private

  DIRECTIONS = %w[N S E W]

  def next_step(location, step, infinite = false)
    # p "next_step() #{location} #{step}/#{@max_step}"

    path = []
    depth = ''
    step.times do
      depth += '---'
    end

    # p "returning as step <= max_step #{step}" unless step <= @max_step
    return unless step <= @max_step

    # puts "\n"

    # p "checking if #{location} #{@rock_locations[location[0]].include? location[1]}"
    # p "step #{step}"
    # puts "\n#{depth} location #{location} step #{step}"
    @found_tiles[location[0]] ||= []
    @found_tiles[location[0]].delete(location[1])

    x = location[1]
    y = location[0]
    h = @map_dimensions[0]
    w = @map_dimensions[1]

    north = nil
    south = nil
    east = nil
    west = nil

    if infinite
      north = [y - 1, x]
      south = [y + 1, x]
      east = [y, x + 1]
      west = [y, x - 1]
    else
      north = y - 1 >= 0 ? [y - 1, x] : nil
      south = y + 1 < h ? [y + 1, x] : nil
      east = x + 1 < w ? [y, x + 1] : nil
      west = x - 1 >= 0 ? [y, x - 1] : nil
    end

    # p "#{location} n#{north} e#{east} s#{south} w#{west}"

    # p 'returning location' if step == @max_step

    return [location.join('-')] if step == @max_step

    mod_x = location[1] % @map_dimensions[1]
    mod_y = location[0] % @map_dimensions[0]

    key = "#{location.join('-')}-#{step}"

    # p 'returning tracker' if @tracking[key]
    return @tracking[key] if @tracking[key]

    step += 1

    [north, south, east, west].each_with_index do |direction, _i|
      next unless direction

      mod_x = direction[1] % @map_dimensions[1]
      mod_y = direction[0] % @map_dimensions[0]

      # p "direction #{DIRECTIONS[i]} #{direction}"

      is_rock = @rock_locations[mod_y]&.include?(mod_x)
      is_tile = @found_tiles[direction[0]]&.include?(direction[1])

      next if is_rock

      unless is_tile
        @found_tiles[direction[0]] ||= []
        @found_tiles[direction[0]].push direction[1]
      end
      # p @found_tiles
      path += next_step(direction, step, infinite) if step <= @max_step
    end

    # p "adding path to tracker path length: #{path.length}"

    @tracking[key] = path.uniq

    path.uniq
  end

  def find_starting(map)
    start = []
    map.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        start = [i, j] if cell == 'S'
      end
    end
    start
  end

  def make_rock_locations(map)
    @rock_locations = {}

    map.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell == '#'
          @rock_locations[i] ||= []
          @rock_locations[i].push j
        end
      end
    end
  end
end
