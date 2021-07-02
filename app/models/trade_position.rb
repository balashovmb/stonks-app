class TradePosition < ApplicationRecord
  include Measureable

  belongs_to :stock
  belongs_to :portfolio

  validates :volume, numericality: { greater_than_or_equal_to: 0 }

  def price
    average_price
  end
end
