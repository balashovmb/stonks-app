class SubscribedQuote < ApplicationRecord
  validates :ticker, presence: true, uniqueness: true
end
