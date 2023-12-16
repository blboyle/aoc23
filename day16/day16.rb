require_relative 'input'

class Day16
  def initialize(input)
    @layout = Layout.new(input)
  end

  def part_one
    @layout.count_energized
  end

  def part_two
    @layout.find_max_energized_count
  end
end

class Layout
  def initialize(input)
    @layout = input.split("\n").reject { |row| row.length == 0 }.map do |row|
      row.split('')
    end
    @energized_list = []
    @energized_map = {}
    @starting_beam = ['E', 0, -1]
  end

  def find_max_energized_count
    # p 'finding max count'
    max = 0

    row_length = @layout[0].length
    layout_length = @layout.length

    # testing
    # @starting_beam = ['S', -1, 3]
    # new_max = count_energized
    # max = new_max if new_max > max
    # return max

    count = 0

    # p 'East'

    # while count < @layout.length
    #   @starting_beam = ['E', count, -1]
    #   new_max = count_energized
    #   @energized_list = []
    #   # @energized_map = {}
    #   max = new_max if new_max > max
    #   count += 1
    # end

    # count = 0

    # p 'West'

    # while count < @layout.length
    #   @starting_beam = ['W', count, row_length]
    #   new_max = count_energized
    #   @energized_list = []
    #   # @energized_map = {}
    #   max = new_max if new_max > max
    #   count += 1
    # end

    count = 0

    p 'South'

    while count < row_length
      @starting_beam = ['S', -1, count]
      new_max = count_energized
      @energized_list = []
      puts "\n"
      puts "\n"
      print_energized_map
      puts "\n"
      p "new_max #{new_max}"
      max = new_max if new_max > max
      count += 1
    end

    # count = 0

    # p 'North'

    # while count < row_length
    #   @starting_beam = ['N', layout_length, count]
    #   new_max = count_energized
    #   @energized_list = []
    #   # @energized_map = {}
    #   max = new_max if new_max > max
    #   count += 1
    # end

    max
  end

  def count_energized
    # p "count energized #{@starting_beam}"
    set_energized
    count = @energized_list.length
    # p "count: #{count}"
    @energized_list = []
    count
  end

  def print_layout
    # p @energized_map

    @layout.map do |row|
      row.join('')
    end.join("\n")
  end

  def print_energized_map
    # p @energized_map

    @energized_map.keys.each do |key|
      p "key #{key} => #{@energized_map[key]}"
    end
  end

  def set_energized
    # p 'set energized'

    @beams = []
    count = 0

    @beams.push @starting_beam

    @beams.each do |_beam|
      # beam = @beams[count]

      # p "beam #{count} - #{beam}"
      # puts "\n"
      move_in_cave @beams[count], count

      count += 1
    end
    0
    # beams_energized
  end

  def move_in_cave(location, beam)
    # p "beam #{beam}"
    # p "location1: #{location}"
    key = location.join('-')
    # p "location2: #{location}"

    # p "beam #{beam} location #{location}"
    direction = location[0]
    y = location[1]
    x = location[2]

    # p "beam array #{@beams.length}"

    item = "#{location[1]}-#{location[2]}"

    # p item == '0--1'

    starting_item = "#{@starting_beam[1]}-#{@starting_beam[2]}"

    @energized_list.push item unless @energized_list.include?(item) || (item == starting_item)
    return @energized_map[key] if @energized_map[key] && (key != @starting_beam.join('-'))

    @energized_map[key] = [] unless @energized_map[key] || (key == @starting_beam.join('-'))

    x += 1 if direction == 'E'

    x -= 1 if direction == 'W'

    y -= 1 if direction == 'N'

    y += 1 if direction == 'S'

    # p "y #{y} x #{x} d#{direction}"

    # p "layout #{@layout.length}"
    # p "layout[0] #{@layout[0].length}"

    # puts "\n"

    # return [key] if @kill_switch > 50

    unless y >= 0 && y < @layout.length
      # p "y #{y} x #{x} break"
      # puts "\n\n"
      return [key]
    end

    unless x >= 0 && x < @layout[0].length
      # p "x #{x} y #{y} break"
      # puts "\n\n"
      return [key]
    end

    next_symbol = @layout[y][x]
    new_location = [direction, y, x]

    # p "next_symbol #{next_symbol}"

    if next_symbol == '|' && %w[E W].include?(direction)
      new_location = ['S', y, x]
      # p "adding to array N #{y} #{x}"

      @beams.push ['N', y, x]
    end

    if next_symbol == '-' && %w[S N].include?(direction)
      new_location = ['E', y, x]
      # p "adding to array W #{y} #{x}"
      @beams.push ['W', y, x]
    end

    if next_symbol == '\\'
      new_location = ['S', y, x] if direction == 'E'
      new_location = ['E', y, x] if direction == 'S'
      new_location = ['W', y, x] if direction == 'N'
      new_location = ['N', y, x] if direction == 'W'
    end

    if next_symbol == '/'
      new_location = ['N', y, x] if direction == 'E'
      new_location = ['W', y, x] if direction == 'S'
      new_location = ['E', y, x] if direction == 'N'
      new_location = ['S', y, x] if direction == 'W'
    end

    # path =

    # @energized_map[key].push location

    path = move_in_cave(new_location, beam)
    path.unshift(key)
    @energized_map[key] = path.clone
    path
  end
end
