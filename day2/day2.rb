require_relative './input'

class Day2
  def initialize(input)
    @play = Play.new(input)
  end

  def part_one
    @play.possible_games_sum
  end

  def part_two
    @play.findSumOfProducts
  end
end

class Play
  def initialize(input)
    games_proccessing = processInput input

    @games = []
    games_proccessing.each do |game|
      @games.push(Game.new(game))
    end
  end

  def possible_games_sum
    possible_games_sum = 0
    @games.each do |game|
      possible_games_sum += game.id.to_i if game.is_possible
    end
    possible_games_sum
  end

  def findSumOfProducts
    sum = 0
    findProductOfFewest.each do |product|
      sum += product
    end
    sum
  end

  def findProductOfFewest
    products = []
    fewestPossibleColours.each do |arr|
      products.push(arr[0] * arr[1] * arr[2])
    end
    products
  end

  def fewestPossibleColours
    fewestColoursArray = []
    @games.each do |game|
      fewestColoursArray.push(game.fewestPossibleColours)
    end
    fewestColoursArray
  end

  private

  def processInput(input)
    gameArray = []
    input.split("\n", -1).each do |game|
      gameSplit = game.split(':')

      gameNumber = gameSplit[0].split(' ')[1]

      currentGame = [gameNumber, {
        'red' => [],
        'green' => [],
        'blue' => []
      }]

      plays = gameSplit[1].split(';')

      plays.each do |play|
        colours = play.split(', ')

        colours.each do |colour|
          colourSplit = colour.split(' ')
          amount = colourSplit[0]
          colourName = colourSplit[1]

          currentGame[1][colourName].push(amount)
        end
      end

      gameArray.push(currentGame)
    end
    gameArray
  end
end

class Game
  @@max_red = 12
  @@max_green = 13
  @@max_blue = 14

  def initialize(newGame)
    @id = newGame[0]
    @reds = newGame[1]['red']
    @greens = newGame[1]['green']
    @blues = newGame[1]['blue']
  end

  attr_reader :id

  def fewestPossibleColours
    lowest_red = 0
    lowest_green = 0
    lowest_blue = 0

    @reds.each do |red|
      lowest_red = red.to_i if red.to_i > lowest_red
    end

    @blues.each do |blue|
      lowest_blue = blue.to_i if blue.to_i > lowest_blue
    end

    @greens.each do |green|
      lowest_green = green.to_i if green.to_i > lowest_green
    end

    [
      lowest_red,
      lowest_green,
      lowest_blue
    ]
  end

  def is_possible
    possible = true

    @reds.each do |red|
      possible = false if red.to_i > @@max_red
    end

    @greens.each do |green|
      possible = false if green.to_i > @@max_green
    end

    @blues.each do |blue|
      possible = false if blue.to_i > @@max_blue
    end

    possible
  end
end

class SmallBag
end

class Cube
  def initialize(color)
    @colour = color
  end
end
