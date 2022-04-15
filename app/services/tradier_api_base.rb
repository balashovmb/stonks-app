require 'uri'
require 'net/http'

class TradierApiBase < Service
  def call
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['Authorization'] = "Bearer #{Rails.application.credentials.tradier_token}"
    request['Accept'] = 'application/json'

    result = http.request(request)
    { result_json: result.read_body, status: result.code, source: 'tradier' }
  end
end
