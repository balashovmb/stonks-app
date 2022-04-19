class Stock < ApplicationRecord
  has_many :deals
  has_many :daily_quotes

  validates :ticker, presence: true, uniqueness: true
  validates :description, presence: true
  validates :current_price, numericality: { greater_than: 0 }
end
