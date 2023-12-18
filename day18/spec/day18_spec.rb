require_relative '../day18'
require_relative '../input'

RSpec.describe do
  # it 'returns correct answer for part 1 example' do
  #   day18 = Day18.new(PuzzleExample1)
  #   answer = day18.part_one
  #   expect(answer).to equal(62)
  # end

  it 'returns correct answer for part 1 input' do
    day18 = Day18.new(PuzzleInput1)
    answer = day18.part_one
    expect(answer).to be < (45449)
    expect(answer).to be > (39623)
    expect(answer).to equal(0)
  end

  # it 'returns correct answer for part 2 example' do
  #   day18 = Day18.new(PuzzleExample1)
  #   answer = day18.part_two
  #   expect(answer).to equal(51)
  # end

  # it 'returns correct answer for part 2 input' do
  #   day18 = Day18.new(PuzzleInput1)
  #   answer = day18.part_two
  #   expect(answer).to equal(8148)
  # end
end
