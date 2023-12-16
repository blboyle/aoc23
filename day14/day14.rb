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
    @tracker = []
    @cycle = []
    # puts print_platform
    # puts "\n"
  end

  def total_load
    titled_board = tilt_board @platform, 'N'
    count_load titled_board
  end

  def store_board_in_tracker(board)
    @tracker.push board.map(&:join).join("\n")
  end

  def store_board_in_winner(board)
    @cycle.push board.map(&:join).join("\n")
  end

  def total_load_after_cycle(max_count_one_based = 1_000_000_000)
    board = @platform.map(&:clone)

    count = 0

    repeats_at_zero_based = nil
    repeat_index_zero_based = nil

    p "begin #{count_load(board)}"
    tally = 0

    # store_board_in_tracker(board)

    while count <= max_count_one_based
      puts "\ncount: #{count}"
      # p "count #{count}" if count % 1_000_000 == 0
      # p "count: #{count} max_count"
      board = tilt_board board, 'N'
      # puts "\n"
      # puts print_platform board
      # puts "\n"
      board = tilt_board board, 'W'
      # puts "\n"
      # puts print_platform board
      # puts "\n"
      board = tilt_board board, 'S'
      # puts "\n"
      # puts print_platform board
      # puts "\n"
      board = tilt_board board, 'E'

      # p "count #{count} load #{count_load board}"
      # print_tracker

      p count_load board
      if @tracker.include? board.map(&:join).join("\n")
        # p board.map(&:join).join("\n")
        repeats_at_zero_based = count if repeats_at_zero_based.nil?
        if repeat_index_zero_based.nil?
          repeat_index_zero_based = @tracker.find_index board.map(&:join).join("\n")
        end

        if @cycle.include? board.map(&:join).join("\n")
          puts "\n\n"
          idx = @cycle.find_index board.map(&:join).join("\n")
          p "count #{count} idx #{idx}"
          puts "\n\n"
          break
        end

        store_board_in_winner board

        p "count: #{count}"
        p 'tracker:'
        p @tracker.find_index board.map(&:join).join("\n")

        # p "count #{count} in here!"
        # puts "\n#{board.map(&:join).join("\n")}"

        # puts "\n"

        # mod = repeat_index % repeats_every
        # p "mod #{mod}"
        # tally += 1
        # break
        # if tally > 50
      end

      store_board_in_tracker(board)
      # puts "\n"
      # puts print_platform board
      # puts "\n"
      count += 1
    end

    # p "repeats_at #{repeats_at}"
    # (repeat_index / count)

    # board_number = repeat_index + mod

    # count 5 is the board I want.
    # count 9 is the same as count 2  = 7

    puts "\n"
    puts "\n"

    p "max_count_one_based #{max_count_one_based}"
    p "repeats_at_zero_based #{repeats_at_zero_based} - repeat_index_zero_based #{repeat_index_zero_based}"
    cycle = repeats_at_zero_based - repeat_index_zero_based
    # p "-----repeat_every #{repeat_every}"
    # board_number = ((max_count - repeat_index) % repeat_every) + repeat_index - 1
    # p "mod #{mod}"
    # p "board_number #{board_number}"

    # new_board = @tracker[board_number].split("\n").map do |row|
    #   row.split('')
    # end
    # p count_load new_board

    # repeats_at
    # max_count
    # starting_board_index

    # board_tracker_index = max_count_one_based

    # (5), 12, 19, 26, 33, 40, 47

    # count_load new_board
    # board_tracker_index

    board_index = (max_count_one_based % cycle) - repeat_index_zero_based + 1

    # p @cycle
    p board_index
    board = @tracker[board_index].split("\n").map do |row|
      row.split('')
    end

    # p board

    puts "max_count #{max_count_one_based} % cycle #{cycle} = #{max_count_one_based % cycle}"
    # count_load @tracker[board_index]
    count_load(board)
  end

  private

  def print_tracker
    @tracker.each_with_index do |item, _i|
      # puts "\n"
      new_item = item.split("\n").reject { |item| item.length == 0 }.map do |row|
        row.split('')
      end

      # p new_item

      # p "i #{i} #{count_load(new_item)}"
      0
    end
  end

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
    # puts "\n"
    # p "tilt board #{direction}"

    return tilt_board_north board if direction == 'N'
    return tilt_board_south board if direction == 'S'
    return tilt_board_east board if direction == 'E'

    tilt_board_west board if direction == 'W'
  end

  def tilt_board_north(board)
    new_board = []

    row_change = -1
    col_change = 0
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

        # p "moving north"
        while inner_y > 0 && new_board[inner_y + row_change][x] != '#' && new_board[inner_y + row_change][x] != 'O'
          inner_y += row_change
          inner_x += col_change
          # p "y #{inner_y} x #{inner_x}"
        end

        new_board[inner_y] = [] unless new_board[inner_y]

        new_board[inner_y][inner_x] = 'O'

        new_board[y][x] = '.' if inner_y < y
        # p "row #{inner_y} cell #{x}"
      end
    end

    new_board
  end

  def tilt_board_west(board)
    new_board = []
    row_change = 0
    col_change = -1
    board.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        new_board[y] = [] unless new_board[y]
        new_board[y][x] = cell if cell != 'O'
        next if cell != 'O'

        inner_x = x.clone

        while inner_x > 0 && new_board[y][inner_x + col_change] != '#' && new_board[y][inner_x + col_change] != 'O'
          inner_x += col_change
        end

        new_board[y] = [] unless new_board[y]

        new_board[y][inner_x] = 'O'

        new_board[y][x] = '.' if inner_x < x
      end
    end

    new_board
  end

  def tilt_board_south(board)
    # p 'tilting board south'
    board = flip_vertical board
    board = tilt_board_north board
    flip_vertical(board)
  end

  def tilt_board_east(board)
    # p 'tilting board east'
    board = flip_horizontal board
    board = tilt_board_west board
    flip_horizontal(board)
  end

  def flip_vertical(board)
    new_board = []

    y = board.length
    x = 0

    while y > 0

      y -= 1

      new_row = []

      x = 0

      while x < board[0].length

        new_row.push board[y][x]

        x += 1
      end

      new_board.push new_row

    end

    new_board
  end

  def flip_horizontal(board)
    # p 'flipping h'
    new_board = []

    y = 0

    while y < board.length
      # p "y #{y}"
      # p "length #{board.length}"

      new_row = []

      x = board[0].length - 1

      while x >= 0

        # p "x #{x}"
        # p "b #{board[y][x]}"

        new_row.push board[y][x]

        x -= 1
      end

      # p "new_row #{new_row}"

      new_board.push new_row

      y += 1

    end

    # p "new board #{new_board}"

    new_board
  end

  def print_platform(input = @platform)
    input.map { |row| row.join(' ') }.join("\n\n")
  end
end
