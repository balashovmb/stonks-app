class Stock < ApplicationRecord
  has_many :deals
  has_many :daily_quotes

  validates :ticker, presence: true, uniqueness: true
end
