class Stock::BroadcastQuotes < Service
  include CableReady::Broadcaster
  include ApplicationHelper

  def initialize(ticker)
    @ticker = ticker
  end

  def call
    stock_data = Stock::Get.call(ticker)
    quote = stock_data[:stocks]&.first&.last&.current_price
    return unless quote

    cable_ready["quotes_#{ticker}"]
      .text_content(
        selector: '#quote',
        text: "Current price: #{money_format(quote)}",
        ticker: ticker
      )
    cable_ready.broadcast
  end

  private

  attr_reader :ticker
end
