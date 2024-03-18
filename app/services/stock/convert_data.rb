class Stock::ConvertData < Service
  def initialize(result_json:, status:, source:)
    @stock_json = result_json
    @status = status
    @source = source
  end

  def call
    case source
    when 'tradier'
      stocks = yield Stock::ConvertDataFromTradier.call(stock_json:)
    end
    Success(stocks.merge({
                           source:,
                           status:
                         }))
  end

  private

  attr_reader :stock_json, :source, :status
end
