require_relative './input'

class Day9
  def initialize(input)
    @oasis_report = OasisReport.new(input)
  end

  def part_one
    @oasis_report.next_values_sum
  end

  def part_two
    @oasis_report.count_ghost_steps
  end
end

class OasisReport
  def initialize(input)
    @value_histories = input.split("\n").reject { |line| line == '' }.map { |line| line.split(' ') }.map do |line|
      History.new line
    end
  end

  def next_values_sum
    values = []
    @value_histories.each_with_index do |history, i|
      next unless i < 5 && i >= 0

      next_value = history.next_value
      # p "next_value #{next_value}"
      values.push next_value
    end
    # p values
    # p @value_histories.length
    # p values.length
    p values
    p values.sum
    values.sum
  end
end

class History
  def initialize(input)
    @list = input.map { |item| item.to_i }
    @tracker = {}
  end

  def next_value(list = @list, depth = 0)
    depth += 1

    if depth < 200
      puts "\n"
      p "list: #{list}"
    end
    # if in_tracker? list
    #   # p "tracker: list with new int: #{list} with #{@tracker[list.join(',')]}"
    #   return @tracker[list.join(',')]
    # end

    # p @tracker
    # p list
    # p @list
    # p "curr_list #{list}"
    # p @list

    # str = ''

    # depth.times do
    #   str += '-'
    # end
    # depth += depth + 1

    # puts "\n"
    # p "#{str}next_value---"
    # puts "\n"

    zero_list = list.sum == 0

    return 0 if zero_list

    next_list = []
    #
    # p "list: #{list}"

    list.each_with_index do |item, i|
      next_list.push list[i + 1] - item if list[i + 1]
    end

    # @tracker[list.join(',')] = list[0] if zero_list
    # p @tracker

    next_int = list[-1] + next_value(next_list, depth)

    # @tracker[list.join(',')] = next_int
    # p @tracker

    puts "\n"
    p "list with new int: #{list} with #{next_int}" if depth < 200

    next_int
  end

  # def in_tracker?(list)
  #   # p 'in tracker' if @tracker[list.join(',')]

  #   @tracker[list.join(',')]
  # end
end
