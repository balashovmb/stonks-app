require 'json'

class Stock::ConvertDataFromTradier < Service
  def initialize(stock_json:)
    @stock_json = stock_json
  end

  def call
    res = {}
    stocks_data = JSON.parse(@stock_json)
    res[:unmatched_symbols] = stocks_data['quotes']['unmatched_symbols']['symbol'] if stocks_data['quotes']['unmatched_symbols']
    stocks_props = stocks_data['quotes']['quote']
    return res unless stocks_props

    if stocks_props.class.to_s == 'Hash'
      res = stock_props_to_hash(stocks_props)
    else
      stocks_props.each do |prop|
        res.merge!(stock_props_to_hash(prop))
      end
      res
    end
  end

  private

  def stock_props_to_hash(stock)
    ticker = stock['symbol']
    { ticker.downcase.to_sym => {
      ticker: ticker,
      description: stock['description'],
      current_price: (stock['last'] * 100).to_i
    } }
  end
end
