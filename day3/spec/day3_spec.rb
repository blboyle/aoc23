require_relative '../day3'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day3 = Day3.new(PuzzleExample1)
    answer = day3.part_one
    expect(answer).to equal(4361)
  end

  it 'returns correct answer for part 1 input' do
    day3 = Day3.new(PuzzleInput1)
    answer = day3.part_one
    expect(answer).to equal(531_561)
  end

  it 'returns correct answer for part 2 example' do
    day3 = Day3.new(PuzzleExample1)
    answer = day3.part_two
    expect(answer).to equal(467_835)
  end

  it 'returns correct answer for part 2 input' do
    day3 = Day3.new(PuzzleInput1)
    answer = day3.part_two
    expect(answer).to equal(83_279_367)
  end
end
