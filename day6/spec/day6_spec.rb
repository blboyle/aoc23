require_relative '../day6'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day6 = Day6.new(PuzzleExample1)
    answer = day6.part_one
    expect(answer).to equal(288)
  end

  it 'returns correct answer for part 1 input' do
    day6 = Day6.new(PuzzleInput1)
    answer = day6.part_one
    expect(answer).to equal(440000)
  end

  it 'returns correct answer for part 2 example' do
    day6 = Day6.new(PuzzleExample2)
    answer = day6.part_two
    expect(answer).to equal(71503)
  end

  it 'returns correct answer for part 2 input' do
    day6 = Day6.new(PuzzleInput2)
    answer = day6.part_two
    expect(answer).to equal(26187338)
  end
end
