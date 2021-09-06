class Deal < ApplicationRecord
  include Measureable

  belongs_to :stock
  belongs_to :portfolio

  validates :volume, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than: 0 }

  validate :enough_cash

  after_create :checkout
  after_create { TradePosition::CreateOrUpdate.call(self) }

  def enough_cash
    errors.add(:_, 'Not enough cash') if portfolio.cash < amount
  end

  def checkout
    cash_diff = amount
    cash_diff = -cash_diff if direction == 'short'
    portfolio.update(cash: portfolio.cash - cash_diff)
  end
end
