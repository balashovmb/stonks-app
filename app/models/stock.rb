class Stock < ApplicationRecord
  validates :ticker, presence: true, uniqueness: true

  def self.get_quote(ticker)
    data = Stocks::GetQuote.call(ticker)
    Stock.create(ticker: ticker.upcase) if data && !data['quotes'].has_key?('unmatched_symbols')
    data
  end
end
