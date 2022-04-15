require 'uri'
require 'net/http'

class DailyQuote::FetchFromTradier < TradierApiBase
  def initialize(stock, options)
    ticker = stock.ticker
    start_of_interval = options[:start_of_interval]
    end_of_interval = options[:end_of_interval]
    @url = URI("https://sandbox.tradier.com/v1/markets/history?symbol=#{ticker}&interval=daily&start=#{start_of_interval}&end=#{end_of_interval}")
  end

  private

  attr_reader :url
end
