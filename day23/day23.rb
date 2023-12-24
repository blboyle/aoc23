require_relative 'input'

class Day23
  def initialize(input)
    @hiking_trail_map = HikingTrailMap.new(input)
  end

  def part_one
    @hiking_trail_map.find_shortest_path
  end

  def part_two
    @hiking_trail_map.find_shortest_path true
  end
end

class HikingTrailMap
  def initialize(input)
    @path_map = []
    @path_lookup = {}
    @path_list = {}

    input.split("\n").reject { |line| line == '' }.each_with_index do |row, _i|
      new_row = []
      row.split('').each do |cell|
        new_row.push cell
      end
      @path_map.push new_row
    end

    @path_map.each_with_index do |row, i|
      @path_lookup[i] = {} unless @path_lookup[i]
      row.each_with_index do |cell, j|
        @path_lookup[i][j] = cell unless @path_lookup[i][j] || cell == '#'
      end
    end

    @destination_y = @path_map.length - 1
  end

  def find_shortest_path(tough = false)
    starting_x = @path_lookup[0].keys[0]
    next_step([0, starting_x], [], 0, tough)
    length_arrays = []
    @path_list.keys.each do |key|
      length_arrays.push @path_list[key].map(&:length).sort
    end
    length_arrays[0][-1] - 1
  end

  def next_step(location, path, step, tough)
    p "location #{location} path #{path}"
    step += 1

    new_path = path.clone

    y = location[0]
    x = location[1]

    new_path.push location
    if y == @destination_y
      @path_list[location.join('-')] ||= []
      @path_list[location.join('-')].push new_path
      return location
    end

    surrounding_list = build_surrounding_list y, x, new_path, tough

    return nil unless surrounding_list.length

    surrounding_list.each do |item|
      next_step(item, new_path, step, tough)
    end
  end

  def build_surrounding_list(y, x, path, tough)
    current_cell = @path_lookup[y][x]

    n = [y - 1, x]
    e = [y, x + 1]
    s = [y + 1, x]
    w = [y, x - 1]

    list =  [n, e, s, w]

    unless tough

      list = [e] if current_cell == '>'

      list = [s] if current_cell == 'v'

      list = [w] if current_cell == '<'

      list = [n] if current_cell == '^'

    end

    list.map do |direction|
      next if direction[0] < 0
      next if direction[1] < 0
      next if direction[0] >= @path_map.length
      next if direction[1] >= @path_map[0].length
      next if path.include? direction

      next unless @path_lookup[direction[0]][direction[1]]

      direction
    end.reject { |item| item.nil? }
  end
end
