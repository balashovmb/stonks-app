class Money::ConvertToViewFormat < Service
  def initialize(summ)
    @summ = summ
  end

  def call
    summ.to_f / 100
  end

  private

  attr_reader :summ
end