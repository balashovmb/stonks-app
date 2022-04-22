class Stock::GetPropsAndDailyQuotes < Service
  def initialize(ticker)
    @ticker = ticker
  end

  def call
    res = { stock_props: nil, stock: nil, quotes: nil }
    stock_with_metadata = Stock::Get.call(@ticker)

    if stock_with_metadata&.dig(:errors)
      return res.merge!(error_message: stock_with_metadata&.dig(:error_message))
    end

    stock = stock_with_metadata[:stocks].first.last

    return unless stock

    quotes = DailyQuote::LoadOrCreate.call(stock)

    res.merge!(stock: stock, quotes: quotes)
  end

  private

  attr_reader :ticker
end
