require 'json'

class DailyQuote::CreateFromTradierData < Service
  def initialize(data, options)
    @daily_quotes_json = data[:result_json]
    @stock = options[:stock]
    @start_of_interval = options[:start_of_interval]
    @end_of_interval = options[:end_of_interval]
  end

  def call
    history_hash = JSON.parse(daily_quotes_json)
    daily_history = history_hash&.dig('history', 'day')
    current_date = start_of_interval
    daily_history.each do |dh|
      current_date = create_non_working_days(dh['date'].to_date, current_date)
      DailyQuote.create(open: convert(dh['open']), high: convert(dh['high']), low: convert(dh['low']),
                        close: convert(dh['close']), date: dh['date'], stock: stock)
      current_date += 1
    end

    current_date = create_non_working_days(end_of_interval, current_date)
    create_non_working_day_at_the_end(current_date)
  end

  private

  attr_reader :daily_quotes_json, :stock, :start_of_interval, :end_of_interval

  def create_non_working_days(future_date, current_date)
    while future_date > current_date
      NonWorkingDay.create(date: current_date)
      current_date += 1
    end
    current_date
  end

  def create_non_working_day_at_the_end(current_date)
    NonWorkingDay.create(date: current_date) if current_date == end_of_interval
  end

  def convert(price)
    Money::ConvertToStorageFormat.call(price)
  end
end
