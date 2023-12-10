require_relative '../day9'
require_relative '../input'

RSpec.describe do
  # it 'returns correct answer for part 1 example' do
  #   day9 = Day9.new(PuzzleExample1)
  #   answer = day9.part_one
  #   expect(answer).to equal(114)
  # end

  it 'returns correct answer for part 1 example' do
    day9 = Day9.new(PuzzleInput1)
    answer = day9.part_one
    # expect(answer).not_to equal(1_921_197_127)
    # expect(answer).to > (1_921_197_127)
    expect(answer).to be < 1_921_197_384
    expect(answer).to be > 34_467_190
    expect(answer).to equal(0)
    ## 1921197384 too high
    ## 34467190 too low
  end

  # it 'returns correct answer for part 2 example' do
  #   day8 = Day8.new(PuzzleExample3)
  #   answer = day8.part_two
  #   expect(answer).to equal(6)
  # end

  # it 'returns correct answer for part 2 input' do
  #   day8 = Day8.new(PuzzleInput1)
  #   answer = day8.part_two
  #   expect(answer).to equal(9_496_801)
  # end
end
