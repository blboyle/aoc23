require_relative '../day7'
require_relative '../input'

RSpec.describe do
  it 'returns correct answer for part 1 example' do
    day7 = Day7.new(PuzzleExample1)
    answer = day7.part_one
    expect(answer).to equal(6440)
  end

  it 'returns correct answer for part 1 input' do
    day7 = Day7.new(PuzzleInput1)
    answer = day7.part_one
    expect(answer).to equal(251_029_473)
  end

  it 'returns correct answer for part 2 example' do
    day7 = Day7.new(PuzzleExample1)
    answer = day7.part_two
    expect(answer).to equal(5905)
  end

  it 'returns correct answer for part 2 input' do
    day7 = Day7.new(PuzzleInput1)
    answer = day7.part_two
    expect(answer).not_to equal(250_925_767)
    expect(answer).not_to equal(250_993_021)
    expect(answer).not_to equal(250_637_576)
    expect(answer).not_to equal(251_224_552)
    expect(answer).to equal(251_003_917)
    expect(answer).to be > (250_993_021)
    expect(answer).to be > (250_925_767)
    expect(answer).to be > (250_972_451)
  end
end
