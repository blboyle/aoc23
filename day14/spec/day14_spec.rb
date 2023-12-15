require_relative '../day14'
require_relative '../input'

RSpec.describe do
  # it 'returns correct answer for part 1 example' do
  #   day14 = Day14.new(PuzzleExample1)
  #   answer = day14.part_one
  #   expect(answer).to equal(136)
  # end

  # it 'returns correct answer for part 1 input' do
  #   day14 = Day14.new(PuzzleInput1)
  #   answer = day14.part_one
  #   expect(answer).to equal(109_345)
  # end

  it 'returns correct answer for part 2 example' do
    day14 = Day14.new(PuzzleExample1)
    answer = day14.part_two
    expect(answer).to equal(64)
  end

  # it 'returns correct answer for part 2 input' do
  #   day14 = Day14.new(PuzzleInput1)
  #   answer = day14.part_two
  #   expect(answer).to be > (110_921)
  #   expect(answer).to be > (112_424)
  #   expect(answer).to equal(269)
  # end
end
