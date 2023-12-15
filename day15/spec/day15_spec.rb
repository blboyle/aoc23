require_relative '../day15'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day15 = Day15.new(PuzzleExample1)
    answer = day15.part_one
    expect(answer).to equal(1320)
  end

  it 'returns correct answer for part 1 input' do
    day15 = Day15.new(PuzzleInput1)
    answer = day15.part_one
    expect(answer).to equal(515_210)
  end

  it 'returns correct answer for part 2 example' do
    day15 = Day15.new(PuzzleExample1)
    answer = day15.part_two
    expect(answer).to equal(145)
  end

  it 'returns correct answer for part 2 input' do
    day15 = Day15.new(PuzzleInput1)
    answer = day15.part_two
    expect(answer).to equal(246_762)
  end
end
