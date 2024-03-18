class Money::ConvertToStorageFormat < Service
  def initialize(sum)
    @sum = sum
  end

  def call
    (sum.to_f * 100).to_i
  end

  private

  attr_reader :sum
end
