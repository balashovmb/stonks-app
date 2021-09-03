require 'uri'
require 'net/http'

class Stock::FetchData < Service
  def initialize(ticker)
    @ticker = ticker
  end

  def call
    url = URI("https://sandbox.tradier.com/v1/markets/quotes?symbols=#{@ticker}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['Authorization'] = "Bearer #{Rails.application.credentials.tradier_token}"
    request['Accept'] = 'application/json'

    result = http.request(request)
    { stock_json: result.read_body, status: result.code, source: 'tradier' }
  end
end
