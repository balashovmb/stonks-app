class Stock::GetPropsAndDailyQuotes < Service
  def initialize(ticker)
    @ticker = ticker
  end

  def call
    res = { stock_props: nil, stock: nil, quotes: nil }
    stock_with_metadata = Stock::GetDataAndCreate.call(@ticker)

    if stock_with_metadata&.dig(:data, :errors)
      return res.merge!(error_message: stock_with_metadata&.dig(:data, :error_message))
    end

    stock_props = stock_with_metadata&.dig(:data, :stocks)&.first&.last
    res.merge!(stock_props: stock_props)

    stock = stock_with_metadata[:stock]

    return unless stock

    quotes = DailyQuote::LoadOrCreate.call(stock)

    res.merge!(stock: stock, quotes: quotes)
  end

  private

  attr_reader :ticker
end
