require_relative '../day19'
require_relative '../input'

RSpec.describe do
  # it 'returns correct answer for part 1 example' do
  #   day19 = Day19.new(PuzzleExample1)
  #   answer = day19.part_one
  #   expect(answer).to equal(62)
  # end

  # it 'returns correct answer for part 1 input' do
  #   day19 = Day19.new(PuzzleInput1)
  #   answer = day19.part_one
  #   expect(answer).to equal(373302)
  # end

  it 'returns correct answer for part 2 example' do
    day19 = Day19.new(PuzzleExample1)
    answer = day19.part_two
    expect(answer).to equal(51)
  end

  # it 'returns correct answer for part 2 input' do
  #   day19 = Day19.new(PuzzleInput1)
  #   answer = day19.part_two
  #   expect(answer).to equal(8148)
  # end
end
