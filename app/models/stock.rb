class Stock < ApplicationRecord
  has_many :deals

  validates :ticker, presence: true, uniqueness: true

  class << self
    def get_stock_data(ticker)
      data = Stocks::Get.call(ticker)
      data && data['quotes'].key?('quote') ? data : nil
    end

    def get_and_create_stock(ticker)
      data = get_stock_data(ticker)
      stock = Stock.find_or_create_by(ticker: ticker.upcase) if data && !data['quotes'].key?('unmatched_symbols')
      { data: data, stock: stock }
    end
  end
end
