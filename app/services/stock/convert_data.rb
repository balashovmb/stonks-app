require 'json'

class Stock::ConvertData < Service
  def initialize(stock_json)
    @stock_json = stock_json
  end

  def call
    result = JSON.parse(@stock_json)
    return result unless result['quotes']['quote'].class.to_s == 'Hash'

    result['quotes']['quote'] = [result['quotes']['quote']]
    result
  end
end
