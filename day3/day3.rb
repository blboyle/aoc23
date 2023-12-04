require_relative './input'

class Day3
  def self.run
    # @schematic = EngineSchematic.new(PuzzleExample1)
    @schematic = EngineSchematic.new(PuzzleInput1)
    # part_1
    part_2
  end

  def self.part_1
    part_numbers = @schematic.part_numbers

    total = 0
    part_numbers.each do |num|
      total += num.to_i
    end
    p total
  end

  def self.part_2
    ratios = @schematic.find_gear_ratios
    total = 0
    ratios.each do |ratio|
      total += ratio
    end
    p total
  end
end

class EngineSchematic
  @@numberStrings = %w[1 2 3 4 5 6 7 8 9 0]

  def initialize(input)
    @schematic = input.strip.split("\n").map do |line|
      line.split('')
    end
  end

  def part_numbers
    maybe_part_numbers = []
    x_max = @schematic[0].length - 1
    y_max = @schematic.length - 1
    x = 0
    y = 0

    current_number = []

    symbols = get_symbols
    part_numbers = []

    symbols.each do |symbol|
      parts = find_symbol_parts(symbol)
      parts.each do |part|
        alreadyIn = false

        part_numbers.each do |part_number|
          alreadyIn = true if part_number[0][0] == part[0][0] && part_number[0][1] == part[0][1]
        end

        part_numbers.push(part) unless alreadyIn
      end
    end

    part_numbers.map do |part_number|
      part_number[1]
    end
  end

  def find_gear_ratios
    gears = find_gears
    gear_ratios = []

    gears.each do |gear|
      parts = find_symbol_parts(gear)
      gear_ratio = parts[0][1].to_i * parts[1][1].to_i
      gear_ratios.push(gear_ratio)
    end
    gear_ratios
  end

  def find_gears
    symbols = get_symbols
    gears = []

    possible_gears = symbols.select do |symbol|
      symbol[0] == '*'
    end

    possible_gears.each do |possible_gear|
      parts = find_symbol_parts(possible_gear)
      gears.push(possible_gear) if parts.length == 2
    end

    gears
  end

  def find_symbol_parts(symbol)
    parts = []
    # p '---'
    # p symbol[1]
    [-1, 0, 1].each do |y_change|
      [-1, 0, 1].each do |x_change|
        y = symbol[1][1] - y_change
        x = symbol[1][0] - x_change

        next if x == symbol[1][0] && y == symbol[1][1]
        next unless @@numberStrings.include?(@schematic[y][x])

        # p "x:#{x} y:#{y} #{@schematic[y][x]}"

        newPart = complete_number(x, y)

        alreadyIn = false

        parts.each do |part|
          alreadyIn = true if part[0][0] == newPart[0][0] && part[0][1] == newPart[0][1]
        end

        parts.push(newPart) unless alreadyIn
      end
    end
    parts
  end

  def complete_number(x, y)
    number = @schematic[y][x]
    rightX = x + 1
    leftX = x - 1
    while rightX < @schematic[y].length && @@numberStrings.include?(@schematic[y][rightX])
      number += @schematic[y][rightX]
      rightX += 1
    end

    while leftX >= 0 && @@numberStrings.include?(@schematic[y][leftX])
      number = @schematic[y][leftX] + number
      leftX -= 1
    end

    [[leftX, y], number]
  end

  def get_symbols
    x_max = @schematic[0].length - 1
    y_max = @schematic.length - 1
    x = 0
    y = 0

    symbols = []

    while y <= y_max

      while x <= x_max

        curr = @schematic[y][x]

        symbols.push([curr, [x, y]]) if curr != '.' && !(@@numberStrings.include? curr)

        x += 1

      end

      y += 1
      x = 0

    end

    symbols
  end
end

# too high
# not 10322555
# not 9660531

# too low
# not 326901
