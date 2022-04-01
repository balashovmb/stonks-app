class Money::ConvertToStorageFormat < Service
  def initialize(summ)
    @summ = summ
  end

  def call
    (summ.to_f * 100).to_i
  end

  private

  attr_reader :summ
end
