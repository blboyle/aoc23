require_relative './input'

class Day7
  def initialize(input)
    @game = Game.new(input)
  end

  def part_one
    @game.play
  end

  def part_two
    @game.play_with_jokers
  end
end

class Game
  def initialize(input)
    @hands = input.split("\n").reject { |line| line == '' }.map do |hand|
      Hand.new hand
    end
  end

  def play_with_jokers
    ranked = rank_hands(true)

    total = 0

    ranked.each_with_index do |item, i|
      total += ((i + 1) * item.bid.to_i)
    end
    total
  end

  def play
    ranked = rank_hands(false)

    total = 0

    ranked.each_with_index do |item, i|
      total += ((i + 1) * item.bid.to_i)
    end
    total
  end

  private

  CARD_ORDER_NO_JOKER = %w[
    2
    3
    4
    5
    6
    7
    8
    9
    T
    J
    Q
    K
    A
  ]

  CARD_ORDER_WITH_JOKER = %w[
    J
    2
    3
    4
    5
    6
    7
    8
    9
    T
    Q
    K
    A
  ]

  def rank_hands(with_jokers)
    card_order = with_jokers ? CARD_ORDER_WITH_JOKER : CARD_ORDER_NO_JOKER

    @hands.sort do |a, b|
      value = 0

      if a.type(with_jokers) > b.type(with_jokers)
        value = 1
      elsif a.type(with_jokers) < b.type(with_jokers)
        value = -1
      end

      value unless value.zero?

      a.cards.each_index do |i|
        next unless value.zero?

        if card_order.find_index(a.cards[i]) > card_order.find_index(b.cards[i])
          value = 1
        elsif card_order.find_index(a.cards[i]) < card_order.find_index(b.cards[i])
          value = -1
        end
      end

      value
    end
  end
end

TYPES_OF_HANDS = {
  'five_of_a_kind' => 7,
  'four_of_a_kind' => 6,
  'full_house' => 5,
  'three_of_a_kind' => 4,
  'two_pair' => 3,
  'one_pair' => 2,
  'high_card' => 1
}

class Hand
  def initialize(input)
    @bid = input.split(' ')[1]
    @cards = input.split(' ')[0].split('').map { |card| card }
  end

  attr_accessor :cards, :bid

  def type(with_jokers)
    tracker = {}

    @cards.each do |card|
      if tracker[card]
        tracker[card] += 1
      else
        tracker[card] = 1
      end
    end

    has_joker = tracker.keys.include? 'J' if with_jokers

    return TYPES_OF_HANDS['five_of_a_kind'] if tracker.keys.length == 1

    if tracker.keys.length == 2

      return TYPES_OF_HANDS['five_of_a_kind'] if has_joker

      return TYPES_OF_HANDS['four_of_a_kind'] if tracker[tracker.keys[0]] == 4 || tracker[tracker.keys[1]] == 4

      return TYPES_OF_HANDS['full_house']

    end

    if tracker.keys.length == 3

      if tracker[tracker.keys[0]] == 3 || tracker[tracker.keys[1]] == 3 || tracker[tracker.keys[2]] == 3
        return TYPES_OF_HANDS['four_of_a_kind'] if has_joker

        return TYPES_OF_HANDS['three_of_a_kind']
      end

      return TYPES_OF_HANDS['full_house'] if has_joker && tracker['J'] == 1

      return TYPES_OF_HANDS['four_of_a_kind'] if has_joker && tracker['J'] == 2

      return TYPES_OF_HANDS['two_pair']

    end

    if tracker.keys.length == 4
      return TYPES_OF_HANDS['three_of_a_kind'] if has_joker

      return TYPES_OF_HANDS['one_pair']
    end

    return TYPES_OF_HANDS['one_pair'] if has_joker

    TYPES_OF_HANDS['high_card']
  end
end
