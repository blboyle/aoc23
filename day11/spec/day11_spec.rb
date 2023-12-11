require_relative '../day11'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day11 = Day11.new(PuzzleExample1)
    answer = day11.part_one
    expect(answer).to equal(4)
  end


  # it 'returns correct answer for part 1 input' do
  #   day11 = Day11.new(PuzzleInput1)
  #   answer = day11.part_one
  #   expect(answer).to equal(6815)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day11 = Day11.new(PuzzleExample1)
  #   answer = day11.part_two
  #   expect(answer).to equal(1)
  # end

  # it 'returns correct answer for part 2 input' do
  #   day11 = Day11.new(PuzzleInput1)
  #   answer = day11.part_two
  #   expect(answer).to equal(269)
  # end
end
