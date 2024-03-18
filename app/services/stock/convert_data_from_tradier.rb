require 'json'

class Stock::ConvertDataFromTradier < Service
  def initialize(stock_json:)
    @stock_json = stock_json
  end

  def call
    res = { stocks: {} }
    stocks_data = JSON.parse(stock_json)
    if stocks_data['quotes']['unmatched_symbols']
      res[:unmatched_symbols] = stocks_data['quotes']['unmatched_symbols']['symbol']
    end
    stocks_props = stocks_data['quotes']['quote']

    return Failure(message: 'Ticker not found') unless stocks_props

    stocks_props = [stocks_props].flatten

    stocks_props.each do |prop|
      res[:stocks].merge!(stock_props_to_hash(prop))
    end
    Success(res)
  end

  private

  attr_reader :stock_json

  def stock_props_to_hash(stock)
    ticker = stock['symbol']
    description = stock['description']
    stock_object = Stock.find_or_create_by(ticker: ticker.upcase, description: description)
    stock_object.update(current_price: Money::ConvertToStorageFormat.call(stock['last']),
                        current_price_updated_at: Time.zone.now)
    { ticker.upcase.to_sym => stock_object }
  end
end
