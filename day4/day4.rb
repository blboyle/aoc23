require_relative './input'

class Day4
  def self.run
    @table = Table.new(PuzzleInput1)
    # @table = Table.new(PuzzleExample1)
    # part_1
    part_2
  end

  def self.part_1
    p @table.count_all_points
  end

  def self.part_2
    p @table.count_total_matching_cards
  end
end

class Table
  def initialize(input)
    @cards = []
    input.strip.split("\n").each do |line|
      @cards.push(ScratchCard.new(line))
    end
    @card_count = {}
    @cards.each do |card|
      @card_count[card.id] = 0
    end

    # p @card_count
  end

  def count_all_points
    total = 0
    @cards.each do |card|
      total += card.points
    end
    total
  end

  def count_total_matching_cards
    @total = 0

    @cards.each do |card|
      # p "--original card #{card.id}"
      count_matching_cards(card, 0) # if card.id == 1
      # p "total #{total}"
    end
    @total
    # p @cardCount
  end

  def count_matching_cards(card, parent)
    id = card.id
    card_index = id - 1

    # buffer = ''
    # parent.times do
    #   buffer += '- - '
    # end

    @card_count[id] += 1

    p "parent #{parent}: id: #{id} :  matches #{card.number_of_matches}"
    @total += 1

    return unless card.number_of_matches.positive?

    while card_index < card.number_of_matches + id - 1
      card_index += 1
      count_matching_cards(@cards[card_index], id) if @cards[card_index]
    end

    # p "#{buffer}new_total: #{new_total}"
    # new_total
  end
end

class ScratchCard
  def initialize(line)
    @id = line.split(':')[0].split(' ')[1].to_i
    @winning_numbers = line.split(':')[1].split('|')[0].split(' ').map do |num|
      num.strip.to_i
    end
    @my_numbers = line.split(':')[1].split('|')[1].split(' ').map do |num|
      num.strip.to_i
    end
  end

  attr_reader :id

  def points
    num_matches = number_of_matches
    exponent = num_matches - 1
    if exponent >= 0
      2**exponent
    else
      0
    end
  end

  def number_of_matches
    total = 0
    @winning_numbers.each do |winner|
      total += 1 if matches? winner
    end
    total
  end

  private

  def matches?(winner)
    @my_numbers.include? winner
  end
end
