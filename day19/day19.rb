require_relative 'input'

class Day19
  def initialize(input)
    @system = MachineRatingSystem.new(input)
  end

  def part_one
    @system.find_ratings
  end

  def part_two
    @system.find_all
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

  def find_all

    @rating_map = {}

    set_from_workflow 'in'

    @rating_map = change_map

    create_map_from_accepted

    @map_from_accepted.keys.each do |key|
      puts "\n\n"
      p key
      @map_from_accepted[key].each do |row|
        puts "\n"
        row.each do |item|
          p item
        end
      end
    end

    51

  end

  def create_map_from_accepted

    @map_from_accepted = {}

    @rating_map["A"].keys.each do |key|
      @rating_map["A"][key].each_with_index do |row, i|

        @map_from_accepted[i] = {} unless @map_from_accepted[i]

        work_backwards key, row, i

      end
    end
  end

  def work_backwards(letter, row, index)

    return if row[0] == "in"

    @map_from_accepted[index][letter] = []  unless @map_from_accepted[index][letter]

    @map_from_accepted[index][letter].push row

    @rating_map[row[0]].keys.each do |key|
      @rating_map[row[0]][key].each do |row|
        work_backwards(key, row, index)
      end
    end


  end

  def change_map
    new_map = {}
    @rating_map.keys.each do |key|

      new_map[key] = {}

      @rating_map[key].each do |row|
        row.each do |item|

          new_map[key][item[1]] = [] unless  new_map[key][item[1]]

          new_map[key][item[1]].push [item[0], item[2]]

        end
      end

    end
    new_map
  end

  def set_from_workflow(input)

    unless input == "R" || input == "A"
    # p "input #{input}"
    end

    workflow = @workflows[input]

    return unless workflow

    rest = []
    next_list = []

    workflow.rules.each do |rule|
      next_list.push rule["destination"]

      if rule["conditional"]
        current = build_checker_array(input, rule["conditional"])
        rest.push build_checker_array(input, rule["conditional"], true)
        @rating_map[rule["destination"]] = [] unless @rating_map[rule["destination"]]
        @rating_map[rule["destination"]].push [current]
      else
        @rating_map[rule["destination"]] = [] unless @rating_map[rule["destination"]]
        @rating_map[rule["destination"]].push rest
      end
    end

    next_list.each do |destination|
      set_from_workflow destination
    end

  end



  def build_checker_array(input, conditional, opposite = false)

    item = nil
    conditional_array = conditional.scan(/(\w)(>|<)(\d*)/)[0]

    unless opposite

      if conditional_array[1] == "<"
        item = [input, conditional_array[0], [1, conditional_array[2].to_i - 1]]
      end

      if conditional_array[1] == ">"
        item = [input, conditional_array[0], [conditional_array[2].to_i + 1, 4000]]
      end

    else

      if conditional_array[1] == "<"
        item = [input, conditional_array[0], [conditional_array[2].to_i, 4000]]
      end

      if conditional_array[1] == ">"
        item = [input, conditional_array[0], [1, conditional_array[2].to_i]]
      end

    end

    item
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
