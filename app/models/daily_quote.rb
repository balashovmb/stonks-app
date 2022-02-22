class DailyQuote < ApplicationRecord
  belongs_to :stock

  validates :stock, uniqueness: { scope: :date }
end
