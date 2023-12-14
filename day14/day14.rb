require_relative 'input'

class Day14
  def initialize(input)
    @notes = PositionsNote.new(input)
  end

  def part_one
    @notes.total_load
  end

  def part_two
    @notes.total_load_after_cycle
  end
end

class PositionsNote
  def initialize(input)
    @platform = input.split("\n").reject { |row| row.length.zero? }.map do |row|
      row.split('')
    end
    puts print_platform
    puts "\n"
  end

  def total_load
    p "total load"
    titled_board = tilt_board @platform, 'N'
    count_load titled_board
  end

  def total_load_after_cycle(max_count = 3)
    p "total load after cycle"
    puts "\n"
    board = @platform.map(&:clone)

    directions = %w[N W S E]

    count = 0

    while count < max_count
      p "count: #{count} max_count"
      direction_index = count % 4
      board = tilt_board board, directions[direction_index]
      count += 1
    end

    count_load board
    64
  end

  private

  def count_load(board)
    count = 0

    board.each_with_index do |row, i|
      row.each_with_index do |cell, _j|
        count += board.length - i if cell == 'O'
      end
    end

    count
  end

  def tilt_board(board = @platform, direction)
    puts "\n"
    p "tilt board #{direction}"

    row_change = 0
    col_change = 0

    row_change = -1 if direction == 'N'

    col_change = -1 if direction == 'W'

    row_change = 1 if direction == 'S'

    col_change = 1 if direction == 'E'

    new_board = []

    board.each_with_index do |row, y|
      new_row = []
      row.each_with_index do |cell, x|
        new_row.push []
      end
      new_board.push new_row
    end

    board.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        # p "x y #{x} #{y}"
        new_board[y] = [] unless new_board[y]
        new_board[y][x] = cell if cell != 'O'
        next if cell != 'O'

        # puts "\n"
        # p "row #{y} col #{x} cell #{cell}"


        inner_y = y.clone
        inner_x = x.clone


        # p "check #{new_board[inner_y][x]}"
        # p "#{inner_y > 0} && #{new_board[inner_y - 1][x] != '#'} && #{new_board[inner_y - 1][x] != 'O'}"

        if direction == "N"
          # p "moving north"
          while inner_y > 0 && new_board[inner_y + row_change][x] != '#' && new_board[inner_y + row_change][x] != 'O'
            inner_y += row_change
            inner_x += col_change
            # p "y #{inner_y} x #{inner_x}"
          end
        end

        if direction == "W"
          while inner_x > 0 && new_board[y][inner_x + col_change] != '#' && new_board[y][inner_x + col_change] != 'O'
            inner_y += row_change
            inner_x += col_change
            # p "y #{inner_y} x #{inner_x}"
          end
        end

        if direction == "S"
          # p "s"
          # p "inner_y #{inner_y} < #{board.length} #{inner_y < board.length}"
          # p "&& #{new_board[inner_y][inner_x] != '#'}"
          # p "&& #{new_board[inner_y][inner_x] != 'O'}"
          while inner_y < board.length && new_board[inner_y][inner_x] != '#' && new_board[inner_y][inner_x] != 'O'
            # p "hi"
            inner_y += row_change
            inner_x += col_change
            # p "y #{inner_y} x #{inner_x}"
          end
        end

        if direction == "E"

          while inner_x < board[0].length && new_board[y][inner_x + col_change] != '#' && new_board[y][inner_x + col_change] != 'O'
            inner_y -= row_change
            inner_x -= col_change
            # p "y #{inner_y} x #{inner_x}"
          end
        end

        new_board[inner_y] = [] unless new_board[inner_y]

        new_board[inner_y][inner_x] = 'O'

        new_board[y][x] = '.' if inner_y < y
        # p "row #{inner_y} cell #{x}"
      end
    end

    puts "\n"
    puts print_platform new_board
    puts "\n"
    new_board
  end

  def print_platform(input = @platform)
    input.map(&:join).join("\n")
  end
end
