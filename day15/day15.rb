require_relative 'input'

class Day15
  def initialize(input)
    @sequence = Sequence.new(input)
  end

  def part_one
    @sequence.sum_outputs
  end

  def part_two
    @sequence.configure
  end
end

class Sequence
  def initialize(input)
    @lenses = {}
    @box_configuration = {}
    @sequence = input.split(',').map do |step|
      Step.new step
    end
  end

  def sum_outputs
    @sequence.sum(&:output)
  end

  def configure
    @sequence.each do |step|
      label = step.step.split(/=|-/)

      @lenses[label[0]] = Lens.new label[0]
    end

    @sequence.each do |step|
      # puts "\n"
      # puts "\n"
      # p "--- step --- #{step.step}"
      # puts "\n"
      # puts "\n"
      result = step.step.split(/=|-/)
      lens = Lens.new result[0], result[1]
      if step.step.include? '='
        add_lens(lens)
      elsif step.step.include? '-'
        remove_lens(lens)
      end
    end

    # p 'hi'

    # p @box_configuration.keys

    total = 0

    @box_configuration.keys.each do |box|
      # puts "\n"
      # p "box #{box}"
      @box_configuration[box].each_with_index do |lens, i|
        # p "lens #{lens}"
        slot = i + 1
        # p slot
        total += lens.focusing_power slot
      end
    end

    # print_config
    total
  end

  def print_config
    @box_configuration.keys.map do |key|
      puts "\n"
      puts "key #{key}: "
      @box_configuration[key].each do |lens|
        p lens
      end
    end
  end

  def focusing_power
    0
  end

  private

  def remove_lens(lens)
    # p "-removing #{lens.label}"
    # puts "\n"
    box = lens.box

    # p "box #{box}"

    return unless @box_configuration[box]

    same_lens_index = @box_configuration[box].find_index do |box_lens|
      box_lens.label == lens.label
    end

    # p "same_lens_index #{same_lens_index}"

    return unless same_lens_index

    @box_configuration[box].delete_at same_lens_index
  end

  def add_lens(lens)
    # p "-add #{lens.label} to #{lens.box}"
    # puts "\n"
    box = lens.box

    @box_configuration[box] = [] unless @box_configuration[box]

    same_lens_index = @box_configuration[box].find_index do |box_lens|
      box_lens.label == lens.label
    end

    if same_lens_index
      @box_configuration[box][same_lens_index] = lens
    else
      @box_configuration[box].push lens
    end
  end
end

class Step
  attr_accessor :step

  def initialize(input)
    @step = input
  end

  def output
    Algorithm.hash @step
  end
end

class Box
end

class Lens
  attr_accessor :label, :focal_length

  def initialize(label, focal_length = nil)
    @label = label
    @focal_length = focal_length
  end

  def focusing_power(slot)
    # p "box #{box}"
    # p "slot #{slot}"
    # p "@focal_length #{@focal_length}"
    (1 + box.to_i) * slot.to_i * @focal_length.to_i
  end

  def box
    # p @label
    Algorithm.hash @label
  end
end

module Algorithm
  def self.hash(input)
    current_value = 0
    input.split('').each do |value|
      ascii = value.ord
      current_value += ascii
      current_value *= 17
      remainder = current_value % 256
      current_value = remainder
    end
    current_value
  end
end
