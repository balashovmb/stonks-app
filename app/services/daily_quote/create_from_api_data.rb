require 'json'

class DailyQuote::CreateFromApiData < Service
  def initialize(daily_quotes_json:, status:, source:, stock:)
    @daily_quotes_json = daily_quotes_json
    @status = status
    @source = source
    @stock = stock
  end

  def call
    case @source
    when 'tradier'
      DailyQuote::CreateFromTradierData.call(daily_quotes_json: @daily_quotes_json, stock: @stock)
    end
  end
end
