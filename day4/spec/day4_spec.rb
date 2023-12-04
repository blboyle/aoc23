require_relative '../day4'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day4 = Day4.new(PuzzleExample1)
    answer = day4.part_one
    expect(answer).to equal(13)
  end

  it 'returns correct answer for part 1 input' do
    day4 = Day4.new(PuzzleInput1)
    answer = day4.part_one
    expect(answer).to equal(27_845)
  end

  it 'returns correct answer for part 2 example' do
    day4 = Day4.new(PuzzleExample1)
    answer = day4.part_two
    expect(answer).to equal(30)
  end

  it 'returns correct answer for part 2 input' do
    day4 = Day4.new(PuzzleInput1)
    answer = day4.part_two
    expect(answer).to equal(9_496_801)
  end
end
