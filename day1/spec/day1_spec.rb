require_relative '../day1'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day1 = Day1.new(Puzzle0Part1)
    answer = day1.part_one
    expect(answer).to equal(142)
  end

  it 'returns correct answer for part 1 input' do
    day1 = Day1.new(Puzzle1)
    answer = day1.part_one
    expect(answer).to equal(54_708)
  end

  it 'returns correct answer for part 2 example' do
    day1 = Day1.new(Puzzle0Part2)
    answer = day1.part_two
    expect(answer).to equal(281)
  end

  it 'returns correct answer for part 2 input' do
    day1 = Day1.new(Puzzle1)
    answer = day1.part_two
    expect(answer).to equal(54_087)
  end
end
