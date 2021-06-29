require 'json'

class Stock::ConvertData < Service
  def initialize(stock_json:, status:, source:)
    @stock_json = stock_json
    @status = status
    @source = source
  end

  def call
    case @source
    when 'tradier'
      stocks = Stock::ConvertDataFromTradier.call(stock_json: @stock_json)
    end
    {
      source: @source,
      status: @status,
      stocks: stocks
    }
  end
end
