require_relative 'input'

class Day10
  def initialize(input)
    @map = SurfacePipeMap.new(input)
  end

  def part_one
    @map.steps_to_furthest
  end

  def part_two
    @map.count_inner_tiles
  end
end

class SurfacePipeMap
  def initialize(input)
    @map = input.split("\n").map do |row|
             row.split('').reject do |cell|
               cell.length == 0
             end
           end.reject { |row| row.length == 0 }
  end

  def steps_to_furthest
    count_steps / 2
  end

  def count_inner_tiles
    flow = build_flow
    # puts print_map
    # puts "\n\n"
    # puts highlight_map flow
    # p flow
    tiles = count_tiles flow
    # p tiles
    # 0
  end

  private

  def count_tiles(flow)
    tracking = {}

    flow.each do |cell|
      tracking[cell[0]] = [] unless tracking[cell[0]]
      tracking[cell[0]].push cell[1]
    end

    tile_count = 0

    tracking.keys.sort.each do |row_index|
      @prev = nil
      row = tracking[row_index]
      row = row.sort
      p row

      inside = false
      row.each_with_index do |cell_index, i|
        # next if @map[row_index][cell_index] == 'L'
        # next if @map[row_index][cell_index] == 'F'

        # p cell_index
        inside = !inside if is_moving? row_index, cell_index

        @prev = @map[row_index][cell_index] if @map[row_index][cell_index] != '-'

        # p "inside #{inside}: #{row_index} #{cell_index} #{@map[row_index][cell_index]}"

        # p "cell: #{cell} #{@map[cell][key]}"

        next unless inside && row[i + 1]

        tiles = row[i + 1] - cell_index - 1

        # p "#{row[i + 1]} #{cell_index}" if tiles > 0
        # p "add #{tiles} tiles" if tiles > 0

        tile_count += tiles
      end
      # puts "\n"
      # p @map[row_index].join('')
      # puts "\n"
      # p "row number: #{row_index}/#{row.length} tile count #{tile_count}"
      # puts "\n"
      # puts "\n"
    end

    # p tracking
    tile_count
  end

  def is_moving?(row_index, cell_index)
    curr = @map[row_index][cell_index]

    curr = find_starting_replacement [row_index, cell_index] if curr == 'S'

    # p "curr == #{curr}"

    return true if curr === '|'

    return true if curr === '7' && @prev != 'L'
    return true if curr === 'F' # #&& @prev != 'J'
    return true if curr === 'J' && @prev != 'F'
    return true if curr === 'L' # && @prev != '7'

    false
  end

  def has_tiles_in_row(row)
    has_tiles = false
    row.each_with_index do |cell, i|
      has_tiles = true if row[i + 1] && row[i + 1] - cell != 1
    end
    # p "#{row} has_tiles: #{has_tiles}"
    has_tiles
  end

  def build_flow
    @flow = []

    starting_point = find_starting_point
    current_point = starting_point
    last_point = nil

    steps = 0

    while starting_point != current_point || (starting_point == current_point && steps.zero?)
      next_coordinates = find_next_coordinates(last_point, current_point)
      steps += 1
      last_point = current_point
      @flow.push current_point
      current_point = next_coordinates
    end
    @flow
  end

  def count_steps
    starting_point = find_starting_point
    current_point = starting_point
    last_point = nil

    steps = 0

    while starting_point != current_point || (starting_point == current_point && steps.zero?)
      next_coordinates = find_next_coordinates(last_point, current_point)
      steps += 1
      last_point = current_point
      current_point = next_coordinates
    end
    steps
  end

  def print_map
    @map.map { |row| row.join(' ') }.join("\n\n")
  end

  def highlight_map(flow)
    highlighted = []
    @map.each_with_index do |row, i|
      highlight_row = []
      row.each_with_index do |_cell, j|
        if flow.include? [i, j]
          highlight_row.push '0'
        else
          highlight_row.push '-'
        end
      end
      highlighted.push highlight_row
    end

    highlighted.map { |row| row.join(' ') }.join("\n\n")
  end

  CONNECTED = {
    'N' => [
      '|', '7', 'F'
    ], 'S' => [
      '|', 'J', 'L'
    ], 'W' => [
      'L', '-', 'F'
    ], 'E' => [
      'J', '-', '7'
    ]
  }

  DIRECTIONS = {
    '|' => %w[N S],
    '-' => %w[E W],
    'L' => %w[N E],
    'J' => %w[N W],
    '7' => %w[S W],
    'F' => %w[S E]
  }

  def find_next_coordinates(last_point, current_point)
    # p "current_point #{current_point}"
    curr = @map[current_point[0]][current_point[1]]
    last = @map[last_point[0]][last_point[1]] if last_point

    curr = find_starting_replacement current_point if curr == 'S'

    # p curr

    directions = DIRECTIONS[curr]

    new_coords = []

    directions.each do |direction|
      # p 'checking directions'
      if direction == 'N'
        new_coords.push [
          current_point[0] - 1,
          current_point[1]
        ]
      end

      if direction == 'W'
        new_coords.push [
          current_point[0],
          current_point[1] - 1
        ]
      end

      if direction == 'E'
        new_coords.push [
          current_point[0],
          current_point[1] + 1
        ]
      end

      next unless direction == 'S'

      new_coords.push [
        current_point[0] + 1,
        current_point[1]
      ]
    end

    new_coords[rand(2).ceil] if last_point.nil?

    new_coords.reject { |cell| cell == last_point }[0]
  end

  def find_starting_replacement(coords)
    surroundings = find_surrounding coords
    connected = find_connected surroundings

    starting = ''

    if connected.include?('N') && connected.include?('S')
      starting = '|'
    elsif connected.include?('E') && connected.include?('W')
      starting = '-'
    elsif connected.include?('N') && connected.include?('E')
      starting = 'L'
    elsif connected.include?('N') && connected.include?('W')
      starting = 'J'
    elsif connected.include?('S') && connected.include?('W')
      starting = '7'
    elsif connected.include?('S') && connected.include?('E')
      starting = 'F'
    end

    starting
  end

  def find_connected(surroundings)
    [
      ['N', CONNECTED['N'].include?(surroundings['N'])],
      ['S', CONNECTED['S'].include?(surroundings['S'])],
      ['E', CONNECTED['E'].include?(surroundings['E'])],
      ['W', CONNECTED['W'].include?(surroundings['W'])]
    ].reject { |item| !item[1] }.map { |item| item[0] }
  end

  def find_surrounding(coords)
    # p "coords #{coords}"
    {
      'N' => @map[coords[0] - 1][coords[1]],
      'E' => @map[coords[0]][coords[1] + 1],
      'S' => @map[coords[0] + 1][coords[1]],
      'W' => @map[coords[0]][coords[1] - 1]
    }
  end

  def find_starting_point
    starting = []
    @map.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        if column == 'S'
          starting = [row_index, column_index]
          break
        end
      end
    end
    starting
  end
end
