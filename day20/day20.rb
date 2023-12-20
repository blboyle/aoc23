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

    @list = []
    @stack = []
    @item_map = {}
    @flip_flip_map = {}
    @conjunction_map = {}

    input.split("\n").reject{|item| item == ""}.map do |list_item|
      @list.push ListItem.new list_item
    end

    @list.each do |item|
      @item_map[item.name] = item
      if item.type == "f"
        @flip_flip_map[item.name] = 0
      end
    end


  end



  def press_button

    puts "\npressing button\n\n"
    @stack.push(['button', 0, 'broadcaster'])

    while @stack.length > 0
      # p "stack:"
      # p @stack
      current_step = @stack.shift

      process_step current_step

    end

  end

  def process_step step


    puts  "\n---step #{step}"

    puts "\n"


    origin = step[0]
    pulse = step[1]
    name = step[2]
    destinations = @item_map[name].destinations
    type = @item_map[name].type

    new_pulse = pulse
    sends_pulse = false

    # p "pulse #{pulse} new_pulse #{new_pulse}"
    # p "origin #{origin}"
    # p "type #{type}"
    # p "name #{name}"

    if type == "broadcaster"
      sends_pulse = true
    end

    # p "type #{type}"
    if type == "f"
      # p "pulse #{pulse}"
      if pulse == 0
        @flip_flip_map[name] = 0 unless @flip_flip_map[name]
        @flip_flip_map[name] = @flip_flip_map[name] == 0 ? 1 : 0
        sends_pulse = true

        # p @flip_flip_map
        # p name

        if @flip_flip_map[name] == 1
          new_pulse = 1
        elsif @flip_flip_map[name] == 0
          new_pulse 0
        end
      end
    end

    if type == "c"
      p name
      @conjunction_map[name] = {} unless @conjunction_map[name]
      @conjunction_map[name][origin] ||= 0
      @conjunction_map[name][origin] = pulse

      new_pulse = 0

      @conjunction_map[name].keys.each do |input|
        new_pulse = 1 if input == 0
      end

    end

    # p "sends_pulse #{sends_pulse}"

    if sends_pulse
      destinations.each do |d|
        @stack.push [name, new_pulse, d]
      end
    end


  end
end

class ListItem

  attr_reader :name, :destinations, :type

  def initialize input
    @name = input.split(" -> ")[0]
    @type = @name
    unless @name == "broadcaster"
      @type = @name[0] == "%" ? "f" : "c"
      @name = @name[1..]
    end

    @destinations =  input.split(" -> ")[1].split(", ")
  end

end
