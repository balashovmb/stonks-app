class Deal < ApplicationRecord
  include Measureable

  belongs_to :stock
  belongs_to :portfolio

  validate :enough_cash

  after_create :checkout
  after_create { TradePosition::CreateOrUpdate.call(self) }

  def enough_cash
    errors.add(:cash, 'Not enough cash') if portfolio.cash < amount
  end

  def checkout
    # TODO: transaction
    cash_diff = amount * (direction == 'long' ? 1 : -1)
    portfolio.update(cash: portfolio.cash - cash_diff)
  end
end
