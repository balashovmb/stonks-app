require 'json'

class Stock::ConvertData < Service
  def initialize(result_json:, status:, source:)
    @stock_json = result_json
    @status = status
    @source = source
  end

  def call
    case source
    when 'tradier'
      stocks = Stock::ConvertDataFromTradier.call(stock_json: stock_json)
    end
    stocks.merge({
                   source: source,
                   status: status
                 })
  end

  private

  attr_reader :stock_json, :source, :status
end
