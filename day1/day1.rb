require_relative './input'

class Day1
  def initialize(input)
    @calibration_document = CalibrationDocument.new(input)
  end

  def part_one
    @calibration_document.sum_calibration_values
  end

  def part_two
    @calibration_document.sum_calibration_values_with_letters
  end
end

class CalibrationDocument
  NUM_MAP = {
    "one": '1',
    "two": '2',
    "three": '3',
    "four": '4',

    "five": '5',
    "six": '6',
    "seven": '7',
    "eight": '8',
    "nine": '9'
  }.freeze
  NUMS = %w[
    1
    2
    3
    4
    5
    6
    7
    8
    9
  ].freeze
  NUM_WORDS = %w[one two three four five six seven eight nine].freeze

  def initialize(input)
    @input = input
  end

  def convert_to_lines
    @input.split
  end

  def sum_calibration_values
    total = 0

    convert_to_lines.each do |line|
      total += calculate_calibration_value(line)
    end

    total
  end

  def sum_calibration_values_with_letters
    total = 0

    convert_to_lines.each do |line|
      total += calculate_calibration_value_with_letters(line)
    end
    total
  end

  private

  def calculate_calibration_value(line)
    regex = /\d/
    value = line.scan(regex)
    [value[0], value[value.length - 1]].join.to_i
  end

  def calculate_calibration_value_with_letters(line)
    newLine = line
    results = []
    lengthRemoved = 0

    while newLine.length > 1
      NUMS.each do |num|
        index = newLine.index(num)

        results.push([index.to_i + lengthRemoved, num]) unless index.nil?
      end

      NUM_WORDS.each do |word|
        index2 = newLine.index(word)

        results.push([index2.to_i + lengthRemoved, word]) unless index2.nil?
      end

      lengthRemoved += 1

      newLine = newLine[1..-1]
    end

    sorted = results.sort_by { |a| a[0] }

    all_numbers = sorted.map do |a|
      if a[1].length === 1
        a[1].to_i
      else
        NUM_MAP[a[1].to_sym].to_i
      end
    end

    [all_numbers[0], all_numbers[- 1]].join.to_i
  end
end
