class Money::ConvertToViewFormat < Service
  def initialize(sum)
    @sum = sum
  end

  def call
    sum.to_f / 100
  end

  private

  attr_reader :sum
end