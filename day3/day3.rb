require_relative './input.rb'

class Day3
    def self.run 
        self.part_1
        # self.part_2
    end

    private

    def self.part_1
      schematic = EngineSchematic.new(PuzzleExample1)
      part_numbers = schematic.part_numbers
      

      total = 0
      part_numbers.each do |num|
        total = total + num.to_i
      end

    end

    def self.part_2
    end
end

class EngineSchematic

  @@numberStrings = ["1","2","3","4","5","6","7","8","9","0"]

  def initialize input
    @schematic = input.strip.split("\n").map do |line|
      line.split("")
    end
  end

  def part_numbers 
    maybe_part_numbers = []
    x_max = @schematic[0].length - 1
    y_max = @schematic.length - 1
    x = 0
    y = 0

    current_number = []

    symbols = get_symbols

    symbols.each do |symbol|

      symbol_x = symbol[1][0]
      symbol_y = symbol[1][1]

      p symbol_x
      p symbol_y


    end

    # while y <= y_max  

    #   while x <= x_max  

    #     curr = @schematic[y][x]
      
    #     if curr != "."

    #       if @@numberStrings.include? curr 
    #         current_number.push(curr)
    #       end 

    #     else

    #       if current_number.length > 0
    #         maybe_part_numbers.push(current_number)
    #       end

    #       current_number = []
          
    #     end

    #     x+=1

    #   end

    #   y+=1
    #   x=0

    #   if current_number.length > 0
    #     maybe_part_numbers.push(current_number)
    #   end
     
    #   current_number = []
 
    # end

    part_numbers = []
    
    []

  end

  def get_symbols

    x_max = @schematic[0].length - 1
    y_max = @schematic.length - 1
    x = 0
    y = 0

    symbols = []

    while y <= y_max  

      while x <= x_max  

        curr = @schematic[y][x]
     
        if curr != "."

          if !@@numberStrings.include? curr 
            symbols.push([curr, [x,y]])
         
          end
          
        end

        x+=1

      end

      y+=1
      x=0
 
    end

    symbols

  end

end

# not 10322555
# not 9660531