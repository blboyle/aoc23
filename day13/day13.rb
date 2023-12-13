require_relative 'input'

class Day13
  def initialize(input)
    @notes = PatternsNote.new(input)
  end

  def part_one
    @notes.sum_pattern_values
  end

  def part_two
    # @image.count_inner_tiles
  end
end

class PatternsNote
  def initialize input
    @patterns = input.split("\n\n").map do |pattern|
      Pattern.new pattern
    end
  end

  def sum_pattern_values
    # @patterns.sum(&:value)
    @patterns[0].value
  end
end

class Pattern

  def initialize input
    @map = input.split("\n").reject{|item| item.length == 0}.map do |item|
      item.split("")
    end
  end

  def value
  #  return (row_value * 100) if row_value != nil
  column_val = column_value
  column_val if column_val != nil
  end

  private

  def row_value

    puts "\n"
    p '^^ ROW VALUE'

    prev_row = 0
    next_row = 1

    value = nil

    while next_row <= @map.length

      puts "\n----prev_row #{prev_row} next_row #{next_row}"
      rows_match = compare_rows( prev_row, next_row)

      if rows_match
        p "matching"
        value = next_row
        break
      end

      prev_row += 1
      next_row += 1
    end

    p "#{value} value"

    value

  end

  def compare_rows(a,b)

    p "a #{a}         b #{b}"

    line_a = @map[a] ? @map[a].join: ""
    line_b = @map[b] ? @map[b].join: ""

    p "#{line_a} - #{line_b} #{line_a == line_b} continue?"
    if a < 0 || b >= @map.length
      prev_a = @map[a+1] ? @map[a+1].join : ""
      prev_b = @map[b-1] ? @map[b-1].join : ""
      val = prev_a == prev_b
      p "val #{val}"
      return val ? 1 : 0
    end


    if line_a == line_b
      p "#{line_a} - #{line_b} continue"
      a -= 1
      b += 1
      return compare_rows(a,b)
    end

    p "#{line_a} - #{line_b} false"

    return false

  end


  def compare_columns(a,b)

    p "a #{a}         b #{b}"

    line_a = column_to_row(a)
    line_b = column_to_row(b)


    puts "#{a} || #{b} >= #{@map[0].length} done?"
    if a < 0 || b >= @map[0].length
      prev_a = column_to_row(a+1) ? column_to_row(a+1) : ""
      prev_b = column_to_row(b-1) ? column_to_row(b-1) : ""
      val = prev_a == prev_b
      p "val #{val}"
      return val ? 1 : 0
    end


    puts "#{line_a} - #{line_b} #{line_a == line_b} continue?"
    if line_a == line_b
      puts "#{line_a} - #{line_b} continue"
      a -= 1
      b += 1
      return compare_rows(a,b)
    end

    puts "#{line_a} - #{line_b} false"

    return false

  end

  def column_to_row column_index

    columns = @map.map do |row|
      p column_index
      row[column_index]
    end
    columns.join
  end

  def column_value
    puts "\n"
    p '^^ COLUMN VALUE'

    prev_column = 0
    next_column = 1

    value = nil

    while next_column <= @map[0].length

      puts "\n----prev_column #{prev_column} next_column #{next_column}"
      columns_match = compare_columns( prev_column, next_column)

      if columns_match
        p "matching"
        value = next_column
        break
      end

      prev_column += 1
      next_column += 1
    end

    p "#{value} value"

    value

  end
end
