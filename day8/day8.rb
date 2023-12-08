require_relative './input'

class Day8
  def initialize(input)
    @desert_navigation = DesertNavigation.new(input)
  end

  def part_one
    @desert_navigation.count_steps_to_end
  end

  def part_two
    @desert_navigation.count_ghost_steps
  end
end

class DesertNavigation

  def initialize input
    @instructions = input.split("\n\n")[0].strip
    @map = {}

    input.split("\n\n")[1].strip.split("\n").each do |node|
      first = node.split(" = ")[0]
      last = /\((\w+), (\w+)\)/.match(node.split(" = ")[1])
      @map[first] = {
        "L" => last[1],
        "R" => last[2]
      }
    end
  end

  def count_steps_to_end

    location = "AAA"
    steps = 0
    index = 0

    while location != "ZZZ"
      side = @instructions[index]

      steps += 1

      newLocation = @map[location][side]

      if index == @instructions.length - 1
        index = 0
      else
        index += 1
      end
      location = newLocation
    end

    steps

  end

  def count_ghost_steps

    steps = 0

    starting_nodes = @map.keys.filter { |key| /\w\wA/.match(key) }

    current_nodes = starting_nodes

    while !at_end(current_nodes)
      current_nodes = navigate current_nodes
    end



    # location = "AAA"
    # steps = 0
    # index = 0

    # while location != "ZZZ"
    #   side = @instructions[index]

    #   steps += 1

    #   newLocation = @map[location][side]


    #   location = newLocation
    # end

    steps

  end

  def navigate(nodes)
    ["12Z", "42Z"]
  end

  def at_end nodes

    nodes.all? do |node|
      p node
      /\w\wZ/.match(node)
    end

  end

end
