require 'input.rb'

class Day1
    def self.run 
        @calibration_document = CalibrationDocument.new(Puzzle1)

        part_1 
        part_2 
    end

    def part_1
        @calibration_document.sum_calibration_values
    end

    def part_1
        @calibration_document.sum_calibration_values_with_letters
    end
end

class CalibrationDocument
  @@num_map = {
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",

    
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9",
  }
  @@nums = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
  ]
  @@numWords = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

  def initialize(input)
    @input = input
  end
 

  def convert_to_lines
    @input.split
  end

  def sum_calibration_values
    total = 0

    convert_to_lines.each do |line|
      total = total + calculate_calibration_value(line)
    end
    total
  end

  def sum_calibration_values_with_letters
    total = 0

    convert_to_lines.each do |line|
      total = total + calculate_calibration_value_with_letters(line)
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
      @@nums.each do |num|
        index = newLine.index(num)

        if index != nil
          results.push([index.to_i + lengthRemoved, num])
        end
      end

      @@numWords.each do |word|
        index2 = newLine.index(word)

        if index2 != nil
          results.push([index2.to_i + lengthRemoved, word])
        end
      end

      lengthRemoved = lengthRemoved + 1

      newLine = newLine[1..-1]
    end

    sorted = results.sort_by { |a| a[0] }

    all_numbers = sorted.map do |a|
      if a[1].length === 1
        a[1].to_i
      else
        @@num_map[a[1].to_sym].to_i
      end
    end

    [all_numbers[0], all_numbers[all_numbers.length - 1]].join.to_i

  end
end
