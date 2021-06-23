class Deal < ApplicationRecord
  belongs_to :stock
  belongs_to :portfolio

  validate :enough_cash

  after_create :checkout

  enum direction: {
    short: 0,
    long: 1
  }

  def amount
    volume * price
  end

  def enough_cash
    errors.add(:cash, 'Not enough cash') if portfolio.cash < amount
  end

  def checkout
    # TODO: transaction
    portfolio.update(cash: portfolio.cash - amount)
  end
end
