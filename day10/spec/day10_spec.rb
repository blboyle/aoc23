require_relative '../day10'
require_relative '../input'

RSpec.describe do
  # it 'returns correct answer for part 1 example' do
  #   day10 = Day10.new(PuzzleExample1)
  #   answer = day10.part_one
  #   expect(answer).to equal(4)
  # end

  # it 'returns correct answer for part 1 example' do
  #   day10 = Day10.new(PuzzleExample2)
  #   answer = day10.part_one
  #   expect(answer).to equal(8)
  # end

  # it 'returns correct answer for part 1 input' do
  #   day10 = Day10.new(PuzzleInput1)
  #   answer = day10.part_one
  #   expect(answer).to equal(6815)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day10 = Day10.new(PuzzleExample1)
  #   answer = day10.part_two
  #   expect(answer).to equal(1)
  # end

  it 'returns correct answer for part 2 example' do
    day10 = Day10.new(PuzzleExample3)
    answer = day10.part_two
    expect(answer).to equal(4)
  end

  it 'returns correct answer for part 2 example' do
    day10 = Day10.new(PuzzleExample4)
    answer = day10.part_two
    expect(answer).to equal(8)
  end

  it 'returns correct answer for part 2 example' do
    day10 = Day10.new(PuzzleExample5)
    answer = day10.part_two
    expect(answer).to equal(10)
  end

  it 'returns correct answer for part 2 input' do
    day10 = Day10.new(PuzzleInput1)
    answer = day10.part_two
    expect(answer).to equal(269) 
  end
end
