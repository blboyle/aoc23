require_relative 'input'

class Day13
  def initialize(input)
    @notes = PatternsNote.new(input)
  end

  def part_one
    @notes.sum_pattern_values
  end

  def part_two
    @notes.sum_smudged_values
  end
end

class PatternsNote
  def initialize(input)
    @patterns = input.split("\n\n").map do |pattern|
      Pattern.new pattern
    end
  end

  def sum_pattern_values
    # @patterns.sum(&:value)
    @patterns[3].value
  end

  def sum_smudged_values
    # @patterns.sum do |pattern|
    #   pattern.make_smudged
    #   pattern.process_smudged

    #   1
    # end
    # @patterns.each(&:make_smudged)
    # count = 0
    # @patterns.sum do |pattern|
    #   p "count: #{count}"
    #   count += 1
    #   pattern.process_smudged
    # end

    @patterns[3].make_smudged
    @patterns[3].process_smudged
    # 0
  end
end

class Pattern
  attr_accessor :column_value, :parent, :row_value

  def initialize(input, parent = nil)
    @map = input.split("\n").reject { |item| item.length == 0 }.map do |item|
      item.split('')
    end
    @column_map = columns_to_rows
    @column_value = nil
    @row_value = nil
    @parent = parent
    # puts "\nmap\n "
    # puts print_map @map
    # puts "\ncolumns map\n "
    # puts print_map @column_map
  end

  def print_map(input = @map)
    input.map do |row|
      row.join('')
    end.join("\n")
  end

  def value
    # p 'value()'
    @row_val = get_row_value
    p "row_val #{@row_val}" unless @row_val.nil?
    return (@row_val * 100) unless @row_val.nil?

    @column_val = get_column_value
    p "column_val #{@column_val}" unless @column_val.nil?
    @column_val unless @column_val.nil?
  end

  def process_smudged
    # p "process smudged #{@smudged.length}"
    puts "\n"
    puts print_map @map
    puts "\n"
    # p 'parentValue--'
    parent_value = value
    val = nil

    @smudged.each_with_index do |smudge, i|
      # puts "\n"
      p "i: #{i}"
      p "col #{@column_value}"
      # p smudge.length * smudge[0].length
      # p "smudge #{smudge.inspect}"

      next unless i > 13 && i < 15

      puts smudge.print_map

      new_val = smudge.value

      p "new_val #{new_val}"
      p "parent_value #{parent_value}"

      next unless new_val && new_val != parent_value

      # puts "\n\n#{i}"
      puts smudge.print_map

      val = new_val
      break
      # p "--val #{new_val}"
      # p "--pvalue #{parent_value}"
    end

    p "val #{val}"

    val

    # if val
    #   p '&'
    # else
    #   p '-'
    # end
    # 0
  end

  def make_smudged
    # p 'making smudged()'
    @smudged = []
    @map.each_with_index do |row, i|
      row.each_with_index do |_cell, j|
        new_map = @map.map(&:clone)

        if @map[i][j] == '.'
          new_map[i][j] = '#'
        elsif @map[i][j] == '#'
          new_map[i][j] = '.'
        end

        pattern = new_map.map do |row|
          row.join
        end.join("\n")

        @smudged.push Pattern.new pattern, self
      end
    end
  end

  private

  def get_row_value
    # p 'row_value()'
    # puts "\n"
    # p '^^ ROW VALUE'

    prev_row = 0
    next_row = 1

    value = nil

    # puts 'row value'

    while next_row <= @map.length

      # puts "\n----prev_row #{prev_row} next_row #{next_row}"
      rows_match = compare_rows(prev_row, next_row)

      if rows_match
        p 'matching'
        # puts print_map

        if @parent
          if next_row != @parent.row_value
            value = next_row
            break
          end

        else
          value = next_row
          break
        end

      end

      prev_row += 1
      next_row += 1
    end

    # p "#{value} value" unless value.nil?

    value
  end

  def compare_rows(a, b)
    # p 'compare_rows()'
    # p "a #{a}         b #{b}"

    line_a = @map[a] ? @map[a].join : ''
    line_b = @map[b] ? @map[b].join : ''

    # p "#{line_a} - #{line_b} #{line_a == line_b} continue?"
    if a < 0 || b >= @map.length
      prev_a = @map[a + 1] ? @map[a + 1].join : ''
      prev_b = @map[b - 1] ? @map[b - 1].join : ''
      val = prev_a == prev_b
      # p "val #{val}"
      return val
    end

    if line_a == line_b
      # p "#{line_a} - #{line_b} continue"
      a -= 1
      b += 1
      return compare_rows(a, b)
    end

    # p "#{line_a} - #{line_b} false"

    false
  end

  def compare_columns(a, b)
    # p "a #{a}         b #{b}"

    line_a = @column_map[a] ? @column_map[a].join : ''
    line_b = @column_map[b] ? @column_map[b].join : ''

    p "line a #{@column_map[a]}"
    p "line b #{@column_map[b]}"

    p "#{line_a} - #{line_b} #{line_a == line_b} continue?"
    p "#{a} || #{b} >= #{@column_map.length} continue?"
    puts "\n"
    puts print_map @column_map
    puts "\n"
    if a < 0 || b >= @column_map.length
      prev_a = @column_map[a + 1] ? @column_map[a + 1].join : ''
      prev_b = @column_map[b - 1] ? @column_map[b - 1].join : ''
      val = prev_a == prev_b
      # p "val #{val}"
      return val
    end

    if line_a == line_b
      # p "#{line_a} - #{line_b} continue"
      a -= 1
      b += 1
      return compare_columns(a, b)
    end

    # p "#{line_a} - #{line_b} false"

    false
  end

  def columns_to_rows
    new_map = []

    @map[0].each do |_cell|
      new_map.push []
    end

    @map.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        new_map[j][i] = cell
      end
    end

    new_map
  end

  def get_column_value
    # p 'column_value()'
    puts "\n"
    p '^^ COLUMN VALUE'

    prev_column = 0
    next_column = 1

    value = nil

    while next_column <= @column_map.length

      puts "\n----prev_column #{prev_column} next_column #{next_column}"
      columns_match = compare_columns(prev_column, next_column)

      if columns_match
        p 'matching'
        p "next_column #{next_column} col val #{@column_val}"

        if @parent
          p @parent.column_value
          if next_column != @parent.column_value
            p 'in here'
            value = next_column
            break
          end
        else

          p 'in here 2'
          value = next_column
          break

        end

      end

      prev_column += 1
      next_column += 1
    end

    # p "#{value} value"

    value
  end
end
