class Stock < ApplicationRecord
  validates :ticker, presence: true, uniqueness: true

  def self.get_quote(ticker)
    data = Stocks::Get.call(ticker)
    return nil unless data && !data['quotes'].has_key?('unmatched_symbols')

    Stock.create(ticker: ticker.upcase)
    data
  end
end
