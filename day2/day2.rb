require_relative './input.rb'

class Day2
    def self.run 
        # self.part_1
        self.part_2
    end

    private

    def self.part_1
      play = Play.new(PuzzlaInput1)
    end

    def self.part_2
      play = Play.new(PuzzlaInput1)
      p play.findSumOfProducts
    end
end

class Play


  @@games = []
  @@possible_games_sum = 0

  def initialize input
    @gamesProccessing = processInput input

    @gamesProccessing.each do |game|
      @@games.push(Game.new(game))
    end

    @@games.each do |game|
      if game.isPossible
        @@possible_games_sum += game.id.to_i
      end
    end

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
    @@games.each do |game|
      fewestColoursArray.push(game.fewestPossibleColours)
    end
    fewestColoursArray
  end

  private

  def processInput input
    gameArray = []
    input.split("\n", -1).each do |game|
      gameSplit = game.split(":")

      gameNumber = gameSplit[0].split(" ")[1]

      currentGame = [gameNumber,{
        "red"=> [],
        "green"=> [],
        "blue"=>[]
      }]

      plays = gameSplit[1].split(";")

      plays.each do |play|
        colours = play.split(", ")
        
        colours.each do |colour|
          colourSplit = colour.split(" ")
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

  def initialize newGame
    @id = newGame[0]
    @reds = newGame[1]["red"]
    @greens = newGame[1]["green"]
    @blues = newGame[1]["blue"]
  end

  def id
    @id
  end

  def fewestPossibleColours
    lowest_red = 0
    lowest_green = 0
    lowest_blue = 0 

    @reds.each do |red|
      if red.to_i > lowest_red
        lowest_red = red.to_i
      end
    end

    @blues.each do |blue|
      if blue.to_i > lowest_blue
        lowest_blue = blue.to_i
      end
    end


    @greens.each do |green|
      if green.to_i > lowest_green
        lowest_green = green.to_i
      end
    end

    [
      lowest_red,
      lowest_green,
      lowest_blue,
    ]
  end

  def isPossible 

    possible = true

    @reds.each do |red|

      if red.to_i > @@max_red
        possible = false
      end
    end

    @greens.each do |green|
      if green.to_i > @@max_green
        possible = false
      end
    end

    @blues.each do |blue|
      if blue.to_i > @@max_blue
        possible = false
      end
    end

    possible

  end

end

class SmallBag
end

class Cube
  def initialize color
    @colour = color
  end
end