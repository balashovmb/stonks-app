class TradePosition < ApplicationRecord
  include Measureable

  belongs_to :stock
  belongs_to :portfolio

  def price
    average_price
  end
end
