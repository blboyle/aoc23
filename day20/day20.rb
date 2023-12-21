require_relative 'input'

class Day20
  def initialize(input)
    @config = ModuleConfiguration.new(input)
  end

  def part_one
    @config.press_button true
  end

  def part_two
    @config.press_button
  end
end

class ModuleConfiguration

  def initialize input

    @list = []
    @stack = []
    @item_map = {}
    @flip_flip_map = {}
    @conjunction_map = {}
    @count = [0,0]
    @found = false

    input.split("\n").reject{|item| item == ""}.map do |list_item|
      @list.push ListItem.new list_item
    end

    @list.each do |item|
      @item_map[item.name] = item
      if item.type == "f"
        @flip_flip_map[item.name] = 0
      end
    end

    @list.each do |item|

      item.destinations.each do |dest|

        next if dest == "output"

        if dest == "rx"
          @conjunction_map[dest] ||= {}
          @conjunction_map[dest][item.name] = 0
        elsif @item_map[dest].type == "c"
          @conjunction_map[dest] ||= {}
          @conjunction_map[dest][item.name] = 0
        end

      end

    end

  end



  def press_button first = false

    cycles = first ? 1000 : 100000000000000

    # puts "\npressing button\n\n"

    # puts "\n"
    cycle = 0
    cycles.times do
      cycle += 1

      # p "cycle #{cycle}" if cycle % 100000 == 0
        @stack = []
        @stack.push(['button', 0, 'broadcaster'])


      while @stack.length > 0
        # p @flip_flip_map
        # p @conjunction_map
        # p "stack:"
        # p @stack
        current_step = @stack.shift

        process_step current_step

        if @found
          break
        end

      end

      if @found
        break
      end
    end

    return @count[0] * @count[1] if first
    cycle

    # p @conjunction_map

  end

  def process_step step

    # puts  "\n---step #{step}"

    origin = step[0]
    pulse = step[1]
    name = step[2]

    @count[pulse] += 1

    # p @conjunction_map["rx"]
    # p @conjunction_map["hb"]
    # p @conjunction_map["js"]
    # p @conjunction_map["zb"]
    # p @conjunction_map["bs"]
    # p @conjunction_map["rr"]

    if pulse == 1

      # p @conjunction_map["rx"]
      # p @conjunction_map["hb"]

      # p "name #{name} pulse #{pulse}" if name == "gr"
      # p "name #{name} pulse #{pulse}" if name == "st"
      # p "name #{name} pulse #{pulse}" if name == "bn"
      # p "name #{name} pulse #{pulse}" if name == "lg"
    end

    # if name == "rx" && pulse == 0
    #   @found = true
    #   return
    # end

    return if name == "output" || name == "rx"

    # p name
    # p @item_map[name]
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
          new_pulse = 0
        end
      end
    end

    if type == "c"
      sends_pulse = true
      # p name
      # p @conjunction_map
      @conjunction_map[name] = {} unless @conjunction_map[name]
      @conjunction_map[name][origin] ||= 0
      @conjunction_map[name][origin] = pulse
      # p @conjunction_map

      new_pulse = 0

      @conjunction_map[name].keys.each do |key|
        # p "input #{key}"
        new_pulse = 1 if @conjunction_map[name][key] == 0
      end

      # p "new_pulse #{new_pulse}"

    end

    # p "sends_pulse #{sends_pulse}"

    if sends_pulse
      destinations.each do |d|
        # p "sending #{[name, new_pulse, d]}"
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
