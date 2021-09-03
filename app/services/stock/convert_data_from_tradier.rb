require 'json'

class Stock::ConvertDataFromTradier < Service
  def initialize(stock_json:)
    @stock_json = stock_json
  end

  def call
    res = { stocks: {} }
    stocks_data = JSON.parse(@stock_json)
    if stocks_data['quotes']['unmatched_symbols']
      res[:unmatched_symbols] = stocks_data['quotes']['unmatched_symbols']['symbol']
      res[:errors] = true
      res[:error_message] = 'Ticker not found'
    end
    stocks_props = stocks_data['quotes']['quote']
    return res unless stocks_props

    if stocks_props.class.to_s == 'Hash'
      res[:stocks] = stock_props_to_hash(stocks_props)
    else
      stocks_props.each do |prop|
        res[:stocks].merge!(stock_props_to_hash(prop))
      end
    end
    res
  end

  private

  def stock_props_to_hash(stock)
    ticker = stock['symbol']
    { ticker.downcase.to_sym => {
      ticker: ticker,
      description: stock['description'],
      current_price: Money::ConvertToStorageFormat.call(stock['last'])
    } }
  end
end
