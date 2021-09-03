class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :deals
  has_many :trade_positions

  validates :cash, numericality: { greater_than_or_equal_to: 0 }

  def get_or_add_cash(params)
    Portfolio::GetOrAddCash.call(self, params)
  end
end
