require_relative '../day8'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day8 = Day8.new(PuzzleExample1)
    answer = day8.part_one
    expect(answer).to equal(2)
  end

  it 'returns correct answer for part 1 example' do
    day8 = Day8.new(PuzzleExample2)
    answer = day8.part_one
    expect(answer).to equal(6)
  end

  it 'returns correct answer for part 1 input' do
    day8 = Day8.new(PuzzleInput1)
    answer = day8.part_one
    expect(answer).to equal(21389)
  end

  it 'returns correct answer for part 2 example' do
    day8 = Day8.new(PuzzleExample3)
    answer = day8.part_two
    expect(answer).to equal(6)
  end

  # it 'returns correct answer for part 2 input' do
  #   day8 = Day8.new(PuzzleInput1)
  #   answer = day8.part_two
  #   expect(answer).to equal(9_496_801)
  # end
end
