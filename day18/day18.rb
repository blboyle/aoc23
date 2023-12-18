require_relative 'input'

class Day18
  def initialize(input)
    @dig_plan = DigPlan.new(input)
  end

  def part_one
    @dig_plan.count_lava_potential
  end

  def part_two

  end
end

class DigPlan

  def initialize input
    @plan = input.split("\n").reject{ |item| item == ''}.map do |row|
      Step.new row
    end
    @layout = make_big_layout
  end


  def count_lava_potential
    make_edges
    trim_layout
    fill_in_middle
    count_meters
  end

  private

  def count_meters
    p "count_meters()"

    amount = 0

    @layout.each do |row|
      row.each do |cell|
        if cell == "#"
          amount += 1
        end
      end
    end

    amount

  end

  def make_big_layout
    p "make_big_layout()"
    sum_right = 1
    @plan.each_with_index do |step, i|
      if step.direction == "R"
        sum_right += step.amount
      end
    end

    sum_down = 1
    @plan.each do |step|
      if step.direction == "D"
        sum_down += step.amount
      end
    end

    layout = []
    # sum_down.times do
    (sum_down * 3).times do
      new_row = []
      # sum_right.times do
      (sum_right* 3).times do
        new_row.push "."
      end
      layout.push new_row
    end

    layout
  end

  def trim_layout
    p "trim_layout()"

    new_layout = []

    index_array = make_index_array

    max_x = 0
    max_y = 0

    min_x = 0
    min_y = 0


    index_array.each_with_index do |row, i|

      next if row.length == 0

      if min_y == 0
        min_y = i
      end

      max_y = i

      if row[0] > 0 && min_x == 0
        min_x = row[0]
      end

      if row[-1] > 0
        max_x = row[-1]
      end
    end

    @layout.each_with_index do |row, y|

      next if y > max_y
      next if y < min_y

      new_row = []

      row.each_with_index do |cell, x|

        next if x < min_x
        next if x > max_x

        new_row.push cell
      end

      new_layout.push new_row
    end

    puts print_layout new_layout

    @layout = new_layout
  end

  def make_index_array
    p "make_index_array()"
    @layout.map do |row|
      index_row = []
      row.each_with_index do |cell, i|
        if cell == "#"
          index_row.push i
        end
      end
    index_row
    end
  end

  def fill_in_middle
    p "fill_in_middle()"

    new_layout = @layout.map(&:clone)

    index_array = make_index_array

    # p "index_array #{index_array}"

    @layout.each_with_index do |row, y|
      inside = false
      row.each_with_index do |cell, x|

        # p "x #{x}"
        # p "array y #{index_array[y]}"

        next if x == 0
        next if index_array[y].length == 0
        next if x - 1 >= index_array[y][-1]

        if cell == "." && row[x-1] == "#"
        # p "changing inside x #{x} y #{y}"
          inside = !inside
        end

        # p "inside #{inside}"
        if inside
          new_layout[y][x] = "#"
        else
          new_layout[y][x] = cell
        end


      end

    end

    puts "\n"

    puts print_layout new_layout

    @layout = new_layout

  end

  def make_edges
    p "make_edge()"
    @start = [@layout.length / 2,@layout[0].length/2]

    y = @start[0]
    x = @start[1]

    @plan.each_with_index do |step, i|

      break if i > 10

      p "-- step #{step.direction} #{step.amount} x:#{x} y:#{y}"

      change_y = 0
      change_x = 0

      if step.direction == "R"
        change_x = 1
      end

      if step.direction == "L"
        change_x = -1
      end

      if step.direction == "U"
        change_y = -1
      end

      if step.direction == "D"
        change_y = 1
      end

      count = 0
      while count < step.amount
        # p "count #{count} step amount #{step.amount}"
        @layout[y][x] = "#"
        x += change_x
        y += change_y
        count += 1
      end


      # puts print_layout
      # puts "\n"


    end
  end

  def print_layout(layout = @layout)
    layout.map do |row|
      row.join("")
    end.join("\n")
  end

end

class Step

  attr_reader :direction, :amount

  def initialize input
    @direction = input.split(" ")[0]
    @amount = input.split(" ")[1].to_i
    @hex = input.split(' (')[1].split(')')[0]
  end
end
