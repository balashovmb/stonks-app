require 'json'

class DailyQuote::CreateFromTradierData < Service
  def initialize(data, options)
    @daily_quotes_json = data[:daily_quotes_json]
    @stock = data[:stock]
    @start = options[:start]
    @end = options[:end]
  end

  def call
    history_hash = JSON.parse(@daily_quotes_json)
    daily_history = history_hash&.dig('history', 'day')
    current_date = @start
    daily_history.each do |dh|
      current_date = create_non_working_days(dh['date'].to_date, current_date)
      DailyQuote.create(open: convert(dh['open']), high: convert(dh['high']), low: convert(dh['low']),
                        close: convert(dh['close']), date: dh['date'], stock: @stock)
      current_date += 1
    end

    create_non_working_days(@end, current_date)
  end

  private

  def create_non_working_days(date, current_date)
    while date > current_date
      NonWorkingDay.create(date: current_date)
      current_date += 1
    end
    current_date
  end

  def convert(price)
    Money::ConvertToStorageFormat.call(price)
  end
end
