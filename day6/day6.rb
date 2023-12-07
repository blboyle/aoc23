require_relative './input'

class Day6
  def initialize(input)

    @competition = Competition.new(input)
  end

  def part_one
    @competition.number_of_wins_product
  end

  def part_two
    @competition.number_of_wins_product
  end
end

 class Competition
  def initialize(input)

    document = input.split("\n").reject{ |line| line == ""}
    times = document[0].split(":")[1].split(" ")
    distances = document[1].split(":")[1].split(" ")

    @races = []
    times.each_index do |i|
      @races.push Race.new([times[i].to_i, distances[i].to_i])
    end

  end

  def number_of_wins_product
    total = nil
    @races.each do |race|
      if total != nil
        total = total * race.number_of_wins
      else
        total = race.number_of_wins
      end
    end
    total
  end
 end

 class Race

  def initialize input
    @time ||= input[0]
    @distance ||= input[1]
  end

  def number_of_wins

    win_count = 0

    (0..@time).to_a.each do |button_held_for_this_long|

      speed_in_mlps = button_held_for_this_long
      remaining_time = @time - button_held_for_this_long

      distance_covered = speed_in_mlps * remaining_time

      if distance_covered > @distance
        win_count += 1
      end
    end

   win_count

  end
 end
