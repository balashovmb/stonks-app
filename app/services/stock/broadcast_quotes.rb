class Stock::BroadcastQuotes < Service
  include ApplicationHelper

  def initialize(ticker)
    @ticker = ticker
  end

  def call
    stock_data = Stock::Get.call(ticker)
    stock = stock_data.success[:stocks]&.first&.last
    quote = stock.current_price
    return unless quote

    stock.broadcast_update_to(
      "quotes_#{ticker}",
      target: "#{ticker}_price",
      partial: "stocks/current_price", locals: {ticker: ticker, current_price: quote }
    )
  end

  private

  attr_reader :ticker
end
