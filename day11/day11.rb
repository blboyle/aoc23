require_relative 'input'

class Day11
  def initialize(input)
    @image = Image.new(input)
  end

  def part_one
    @image.sum_shortest_paths
    4
  end

  def part_two
    # @image.count_inner_tiles
  end
end

class Image

  def initialize input
    @universe = input.split("\n").reject{ |row| row == ""}.map { |row| row.split("")}
    @expanded_universe= make_expanded_universe
  end

  def sum_shortest_paths
    all_shortest_paths.sum
  end

  private

  def all_shortest_paths
    @galaxies = find_all_galaxies
    pairs = make_galaxy_pairs

    # shortest_path pairs[17]

    paths = pairs.map do |pair|
      shortest_path pair
    end

    []

  end


# "-- 3-6"
# [6, 1]
# [7, 1]
# [7, 2]
# [7, 3]
# [7, 4]
# [7, 5]
# [7, 6]
# [7, 7]
# [7, 8]
# [7, 9]
# [7, 10]
# [7, 11]
# 12/

# "-- 3-6"
# [2, 0]
# [3, 0]
# [3, 1]
# [4, 1]
# [4, 2]
# [5, 2]
# [5, 3]
# [6, 3]
# [6, 4]
# [7, 4]
# [7, 5]
# [7, 6]
# [7, 7]
# [7, 8]
# [7, 9]
# [7, 10]
# [7, 11]
# 17

  def shortest_path pair
    p "-- #{pair}"
    first = pair.split('-')[0]
    last = pair.split('-')[1]

    begin_here = @galaxies[first.to_i - 1]
    end_here =  @galaxies[last.to_i - 1]

    location = begin_here

    steps = 0

    h_movement = begin_here[1] > end_here[1] ? -1: 1
    v_movement = begin_here[0] > end_here[0] ? -1 : 1

    while location != end_here

      p location


      if steps % 2 == 0
        if location[0] != end_here[0]
          location[0] = location[0] + v_movement
          steps += 1
        else
          if location[1] != end_here[1]
            location[1] = location[1] + h_movement
            steps += 1
          end
        end
      else
        if location[1] != end_here[1]
          location[1] = location[1] + h_movement
          steps += 1
        else
          if location[0] != end_here[0]
            location[0] = location[0] + v_movement
            steps += 1
          end
        end
      end



    end

    p steps


  end

  def make_galaxy_pairs
    pairs = []
    @galaxies.each_with_index do |galaxy, i|

      count = 0

      while count < @galaxies.length
        count += 1
        next if count-1 == i

        pair = [
          i + 1,
          count
      ].sort.join("-")

        pairs.push pair if !pairs.include? pair

      end

    end
   pairs
  end

  def find_all_galaxies

    galaxies = []


    @expanded_universe.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell == "#"
          galaxies.push [i, j]
        end
      end
    end

    galaxies

  end

  def make_expanded_universe

    number_of_initial_columns = @universe[0].length
    number_of_initial_rows = @universe.length

    column_step = 0
    row_step = 0

    @initial = {
      "rows"=> {},
      "columns"=> {},
    }

    count = 0

    while column_step < number_of_initial_columns

      @universe.each do |row|

        if row[column_step] === "#"
          count += 1
        end

      end


        @initial['columns'][column_step] = count


      count = 0;

      column_step += 1


    end


    while row_step < number_of_initial_rows

      @universe[row_step].each do |cell|

        if cell === "#"
          count += 1
        end

      end

      @initial['rows'][row_step] = count
      count = 0;

      row_step += 1


    end

    expanded_array = []

    @universe.each_with_index do |row, i|


      expanded_row = []

      row.each_with_index do |cell, j|

        if @initial["columns"][j] === 0
          2.times do
            expanded_row.push cell
          end
        else
          expanded_row.push cell
        end

      end

      if @initial["rows"][i] == 0
        2.times do
          expanded_array.push expanded_row
        end
      else
        expanded_array.push expanded_row
      end

    end

    expanded_array
  end

  def print input
    puts input.map{|row| row.join("")}.join("\n")
  end

end
