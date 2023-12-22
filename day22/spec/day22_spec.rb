require_relative '../day22'
require_relative '../input'

RSpec.describe do
  # it 'returns correct answer for part 1 example' do
  #   day22 = Day22.new(PuzzleExample1)
  #   answer = day22.part_one 6
  #   expect(answer).to equal(16)
  # end

  # it 'returns correct answer for part 1 example' do
  #   day22 = Day22.new(PuzzleInput1)
  #   answer = day22.part_one 64
  #   expect(answer).to equal(3816)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day22 = Day22.new(PuzzleExample1)
  #   answer = day22.part_two 6
  #   expect(answer).to equal(16)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day22 = Day22.new(PuzzleExample1)
  #   answer = day22.part_two 10
  #   expect(answer).to equal(50)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day22 = Day22.new(PuzzleExample1)
  #   p 'before'
  #   answer = day22.part_two 50
  #   p 'after'
  #   expect(answer).to equal(1594)
  # end

  it 'returns correct answer for part 2 example' do
    day22 = Day22.new(PuzzleExample1)
    p 'before'
    answer = day22.part_two 100
    p 'after'
    expect(answer).to equal(6536)
  end

  # it 'returns correct answer for part 2 example' do
  #   day22 = Day22.new(PuzzleExample1)
  #   answer = day22.part_two 500
  #   expect(answer).to equal(167_004)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day22 = Day22.new(PuzzleExample1)
  #   answer = day22.part_two 1000
  #   expect(answer).to equal(668_697)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day22 = Day22.new(PuzzleExample1)
  #   answer = day22.part_two 5000
  #   expect(answer).to equal(16_733_044)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day22 = Day22.new(PuzzleExample1)
  #   answer = day22.part_two 26_501_365
  #   expect(answer).to equal(16_733_044)
  # end

  # it 'returns correct answer for part 2 example' do
  #   day22 = Day22.new(PuzzleExample1)
  #   answer = day22.part_two 100
  #   expect(answer).to equal(6536)
  # end

  # it 'returns correct answer for part 2 input' do
  #   day22 = Day22.new(PuzzleInput1)
  #   answer = day22.part_two
  #   expect(answer).to equal(8148)
  # end
end
