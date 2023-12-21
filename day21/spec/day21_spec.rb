require_relative '../day21'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day21 = Day21.new(PuzzleExample1)
    answer = day21.part_one 6
    expect(answer).to equal(16)
  end

  # it 'returns correct answer for part 1 example' do
  #   day21 = Day21.new(PuzzleInput1)
  #   answer = day21.part_one 64
  #   expect(answer).to equal(11687500)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day21 = Day21.new(PuzzleExample1)
  #   answer = day21.part_two
  #   expect(answer).to equal(51)
  # end

  # it 'returns correct answer for part 2 input' do
  #   day21 = Day21.new(PuzzleInput1)
  #   answer = day21.part_two
  #   expect(answer).to equal(8148)
  # end
end
