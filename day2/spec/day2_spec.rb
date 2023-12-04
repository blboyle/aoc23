require_relative '../day2'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day2 = Day2.new(PuzzleExample1)
    answer = day2.part_one
    expect(answer).to eq(8)
  end

  it 'returns correct answer for part 1 input' do
    day2 = Day2.new(PuzzleInput1)
    answer = day2.part_one
    expect(answer).to eq(2505)
  end

  it 'returns correct answer for part 2 example' do
    day2 = Day2.new(PuzzleExample1)
    answer = day2.part_two
    expect(answer).to eq(2286)
  end

  it 'returns correct answer for part 2 input' do
    day2 = Day2.new(PuzzleInput1)
    answer = day2.part_two
    expect(answer).to eq(70_265)
  end
end
