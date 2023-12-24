require_relative '../day23'
require_relative '../input'

RSpec.describe do
  # it 'returns correct answer for part 1 example' do
  #   day23 = Day23.new(PuzzleExample1)
  #   answer = day23.part_one
  #   expect(answer).to equal(94)
  # end

  # it 'returns correct answer for part 1 example' do
  #   day23 = Day23.new(PuzzleInput1)
  #   answer = day23.part_one
  #   expect(answer).to equal(2162)
  # end

  it 'returns correct answer for part 2 example' do
    day23 = Day23.new(PuzzleExample1)
    answer = day23.part_two
    expect(answer).to equal(154)
  end

  it 'returns correct answer for part 2 example' do
    day23 = Day23.new(PuzzleInput1)
    answer = day23.part_two
    expect(answer).to equal(50)
  end
end
