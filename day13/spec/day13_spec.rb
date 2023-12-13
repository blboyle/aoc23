require_relative '../day13'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day13 = Day13.new(PuzzleExample1)
    answer = day13.part_one
    expect(answer).to equal(405)
  end


  # it 'returns correct answer for part 1 input' do
  #   day13 = Day13.new(PuzzleInput1)
  #   answer = day13.part_one
  #   expect(answer).to equal(6815)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day13 = Day13.new(PuzzleExample1)
  #   answer = day13.part_two
  #   expect(answer).to equal(1)
  # end

  # it 'returns correct answer for part 2 input' do
  #   day13 = Day13.new(PuzzleInput1)
  #   answer = day13.part_two
  #   expect(answer).to equal(269)
  # end
end
