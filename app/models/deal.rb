class Deal < ApplicationRecord
  belongs_to :stock

  enum direction: {
    short: 0,
    long: 1
  }

  def amount
    self.volume * self.price
  end
end
