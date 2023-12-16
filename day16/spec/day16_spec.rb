require_relative '../day16'
require_relative '../input'

RSpec.describe do
  # it 'returns correct answer for part 1 example' do
  #   day16 = Day16.new(PuzzleExample1)
  #   answer = day16.part_one
  #   expect(answer).to equal(46)
  # end

  # it 'returns correct answer for part 1 input' do
  #   day16 = Day16.new(PuzzleInput1)
  #   answer = day16.part_one
  #   expect(answer).to equal(7951)
  # end

  it 'returns correct answer for part 2 example' do
    day16 = Day16.new(PuzzleExample1)
    answer = day16.part_two
    expect(answer).to equal(51)
  end

  # it 'returns correct answer for part 2 input' do
  #   day16 = Day16.new(PuzzleInput1)
  #   answer = day16.part_two
  #   expect(answer).to equal(8148)
  # end
end
