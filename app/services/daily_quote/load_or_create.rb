class DailyQuote::LoadOrCreate < Service
  def initialize(stock, options = {})
    @stock = stock
    @end_of_interval = options[:end_of_interval] || last_day
    @start_of_interval = options[:start_of_interval] || first_day
    @options = options.merge(start_of_interval: @start_of_interval, end_of_interval: @end_of_interval)
  end

  def call
    loaded_quotes = DailyQuote.where(date: start_of_interval..end_of_interval, stock: stock)
    return loaded_quotes.sort_by(&:date) if all_loaded?(loaded_quotes)

    DailyQuote::Create.call(stock, options)
    DailyQuote.where(date: start_of_interval..end_of_interval, stock: stock).sort_by(&:date)
  end

  private

  attr_reader :stock, :end_of_interval, :start_of_interval, :options

  def last_day
    Time.zone.today.yesterday
  end

  def first_day
    last_day - 30
  end

  def all_loaded?(loaded_quotes)
    first_working_day_loaded?(loaded_quotes) && last_working_day_loaded?(loaded_quotes)
  end

  def first_working_day_loaded?(loaded_quotes)
    return true if loaded_quotes.find_by(date: start_of_interval)

    date = start_of_interval
    date += 1 while NonWorkingDay.find_by(date: date)
    loaded_quotes.find_by(date: date)
  end

  def last_working_day_loaded?(loaded_quotes)
    return true if loaded_quotes.find_by(date: end_of_interval)

    date = end_of_interval
    date -= 1 while NonWorkingDay.find_by(date: date)
    loaded_quotes.find_by(date: date)
  end
end
