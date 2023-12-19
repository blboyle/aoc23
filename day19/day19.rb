require_relative 'input'

class Day19
  def initialize(input)
    @system = MachineRatingSystem.new(input)
  end

  def part_one
    @system.find_ratings
  end

  def part_two
    @system.build_map
  end
end

class MachineRatingSystem
  def initialize(input)
    @workflows = {}
    input.split("\n\n")[0].split("\n").reject{|row| row == ''}.each do |workflow|
      key = workflow.split("{")[0].strip
      @workflows[key] = Workflow.new workflow, key
    end

    @parts = input.split("\n\n")[1].split("\n").map do |part|
      part.scan(/\w=(\d+)/)
    end.map do |part|
      part.map do |item|
        item[0].to_i
      end
    end

  end

  def build_map
    count = 0
    x = 0
    m = 0
    a = 0
    s = 0
    4000.times do
      m = 0
      a = 0
      s = 0
      x += 1
      4000.times do
        a = 0
        s = 0
        m += 1
        4000.times do
          s = 0
          a += 1
          4000.times do
            s += 1
            p "Count #{x} #{m} #{a} #{s}"
          end
        end
      end
    end
    p 'done'
  end

  def find_ratings

    a_ratings = []
    @parts.each do |part|

      puts "\n"
      p "part-- #{part}"
      if process_part(part) == "A"
        a_ratings.push part
      end

    end

    amount = 0

    a_ratings.each do |rating|
      amount += rating.sum
    end

    amount
  end

  def process_part part

    destination = "in"

    while destination != "A" && destination != "R"
      destination = get_next_destination part, destination
      p "destination #{destination}"
    end

    destination

  end

  def get_next_destination(part, destination)
    puts "\n"

    next_destination = nil

    @workflows[destination].rules.each do |rule|
      break if next_destination
      # p "--rule--"

      p "rule #{rule['conditional']}"

      next unless !rule["conditional"] || conditional?(part, rule["conditional"])

      p "down here"

      next_destination = rule["destination"]
    end

    p "next dest #{next_destination}"

    next_destination
  end

  LETTERS = ["x","m","a","s"]

  def conditional?(part, conditional)
    conditional_array = conditional.scan(/(\w)(>|<)(\d*)/)[0]

    check = false

    part.each_with_index do |amount, letter_index|

      letter = LETTERS[letter_index]

      p "letter #{letter} #{conditional_array[1] == ">" && conditional[0] == letter}"

      if conditional_array[1] == "<" && conditional[0] == letter
        check = amount.to_i < conditional_array[2].to_i
        p "in here #{check}"
      elsif conditional_array[1] == ">" && conditional[0] == letter
        check = amount.to_i > conditional_array[2].to_i
        p "in here again #{check}"
      end

      if check
        p 'matches'
        break
      end

    end

    check
  end

end

class Workflow

  attr_reader :rules
  def initialize input, key

    @name =  key
    @rules = input.split("{")[1].split("}")[0].split(",").map do |rule|
      conditional = rule.split(":")[0]
      destination = rule.split(":")[-1]

      rule = {}

      rule["destination"] = destination
      rule["conditional"] = conditional if destination != conditional
      rule
    end

  end
end
