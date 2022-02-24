require 'uri'
require 'net/http'

class DailyQuote::FetchFromTradier < Service
  def initialize(stock, options = {})
    @ticker = stock.ticker
    @stock = stock
    @start = options[:start]
    @end = options[:end]
  end

  def call
    url = URI("https://sandbox.tradier.com/v1/markets/history?symbol=#{@ticker}&interval=daily&start=#{@start}&end=#{@end}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['Authorization'] = "Bearer #{Rails.application.credentials.tradier_token}"
    request['Accept'] = 'application/json'

    result = http.request(request)

    { daily_quotes_json: result.read_body, status: result.code, source: 'tradier', stock: @stock }
  end
end
