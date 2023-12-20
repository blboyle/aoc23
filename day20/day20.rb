require_relative 'input'

class Day20
  def initialize(input)
    @config = ModuleConfiguration.new(input)
  end

  def part_one
    @config.press_button
  end

  def part_two
    # @system.find_all
  end
end

class ModuleConfiguration

  def initialize input

    @stack = []

    @list = input.split("\n").reject{|item| item == ""}.map do |list_item|
      ListItem.new list_item
    end
    @item_map = {}

    @list.each do |item|
      @item_map[item.name] = {}
      @item_map[item.name]["type"] = item.type
      @item_map[item.name]["destinations"] = {}  unless  @item_map[item.name]["destinations"]
      item.destinations.each do |d|
        @item_map[item.name]["destinations"][d] = false
      end
    end

  end



  def press_button

    @stack.push(['button', 0, 'broadcaster'])

    while @stack.length > 0
      current_step = @stack.pop

      process_step current_step

    end

  end

  def process_step step

    destinations = @item_map[step[2]]["destinations"].keys
    pulse = step[1]

    if pulse

    # destinations.each do |d|
    #   @stack.push [step[2], pulse, d]
    # end


    # p "process_step #{destinations}"

  end
end

class ListItem

  attr_reader :name, :destinations, :type

  def initialize input
    @name = input.split(" -> ")[0]
    @type = @name
    unless @name == "broadcaster"
      @type = @name[0] == "%" ? "c" : "i"
      @name = @name[1..]
    end

    @destinations =  input.split(" -> ")[1].split(", ")
  end

end
