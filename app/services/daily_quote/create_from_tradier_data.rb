require 'json'

class DailyQuote::CreateFromTradierData < Service
  def initialize(daily_quotes_json:, stock:)
    @daily_quotes_json = daily_quotes_json
    @stock = stock
  end

  def call
    history_hash = JSON.parse(@daily_quotes_json)

    daily_history = history_hash&.dig('history', 'day')
    daily_history.each do |dh|
      DailyQuote.create(open: convert(dh['open']), high: convert(dh['high']), low: convert(dh['low']),
                        close: convert(dh['close']), date: dh['date'], stock: @stock)
    end
  end

  private

  def convert(price)
    Money::ConvertToStorageFormat.call(price)
  end
end
