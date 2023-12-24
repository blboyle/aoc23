require_relative 'input'

class Day22
  def initialize(input)
    @brick_snapshot = BrickSnapshot.new(input)
  end

  def part_one
    @brick_snapshot.count_removable_bricks
    16
  end

  def part_two
    p nil
  end
end

class BrickSnapshot
  def initialize(input)
    @bricks = input.split("\n").reject { |row| row == '' }.map do |brick|
      Brick.new brick
    end

    @z_y_lookup = {}
    @z_x_lookup = {}

    @bricks.each_with_index do |item, i|
      first = item.first
      last = item.last

      @z_y_lookup[first[2]] = {} unless @z_y_lookup[first[2]]
      @z_y_lookup[last[2]] = {} unless @z_y_lookup[last[2]]

      @z_y_lookup[first[2]][first[1]] = [] unless @z_y_lookup[first[2]][first[1]]
      @z_y_lookup[last[2]][last[1]] = [] unless @z_y_lookup[last[2]][last[1]]

      @z_y_lookup[first[2]][first[1]].push i
      @z_y_lookup[last[2]][last[1]].push i

      @z_x_lookup[first[2]] = {} unless @z_x_lookup[first[2]]
      @z_x_lookup[last[2]] = {} unless @z_x_lookup[last[2]]

      @z_x_lookup[first[2]][first[0]] = [] unless @z_x_lookup[first[2]][first[0]]
      @z_x_lookup[last[2]][last[0]] = [] unless @z_x_lookup[last[2]][last[0]]

      @z_x_lookup[first[2]][first[0]].push i
      @z_x_lookup[last[2]][last[0]].push i
    end

    # puts '--x--'
    # print_map @z_x_lookup
    # puts '--y--'
    # print_map @z_y_lookup
  end

  def count_removable_bricks
    bricks_fall
  end

  private

  def bricks_fall
    new_x = @z_x_lookup.clone

    @z_x_lookup.each_key do |level|
      puts "\nlevel #{level}"
      occupied_x = @z_x_lookup[level].keys
      occupied_y = @z_y_lookup[level].keys

      p occupied_x
      p occupied_y
    end
  end

  def print_map(map)
    map.keys.reverse.each do |key|
      p key
      map[key].each_key do |key2|
        puts "\n #{key2}"
        map[key][key2]&.each do |item|
          puts " -- #{item}"
        end
      end
      puts "\n"
    end
  end
end

class Brick
  attr_reader :first, :last

  def initialize(input)
    @first = input.split('~')[0].split(',').map(&:to_i)
    @last = input.split('~')[1].split(',').map(&:to_i)
  end
end
