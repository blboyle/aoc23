require_relative '../day20'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day20 = Day20.new(PuzzleExample1)
    answer = day20.part_one
    expect(answer).to equal(62)
  end

  # it 'returns correct answer for part 1 example' do
  #   day20 = Day20.new(PuzzleExample2)
  #   answer = day20.part_one
  #   expect(answer).to equal(62)
  # end


  # it 'returns correct answer for part 1 input' do
  #   day20 = Day20.new(PuzzleInput1)
  #   answer = day20.part_one
  #   expect(answer).to equal(373302)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day20 = Day20.new(PuzzleExample1)
  #   answer = day20.part_two
  #   expect(answer).to equal(51)
  # end

  # it 'returns correct answer for part 2 input' do
  #   day20 = Day20.new(PuzzleInput1)
  #   answer = day20.part_two
  #   expect(answer).to equal(8148)
  # end
end
