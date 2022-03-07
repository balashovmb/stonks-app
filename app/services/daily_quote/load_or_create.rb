class DailyQuote::LoadOrCreate < Service
  def initialize(stock, options = {})
    @stock = stock
    @end = options[:end] || last_day
    @start = options[:start] || first_day
    @options = options.merge(start: @start, end: @end)
  end

  def call
    loaded_quotes = DailyQuote.where(date: @start..@end, stock: @stock)
    return loaded_quotes.sort_by(&:date) if all_loaded?(loaded_quotes)

    DailyQuote::Create.call(@stock, @options)
    DailyQuote.where(date: @start..@end, stock: @stock).sort_by(&:date)
  end

  private

  def last_day
    Time.zone.today.yesterday
  end

  def first_day
    @end - 30
  end

  def all_loaded?(loaded_quotes)
    first_working_day_loaded?(loaded_quotes) && last_working_day_loaded?(loaded_quotes)
  end

  def first_working_day_loaded?(loaded_quotes)
    return true if loaded_quotes.find_by(date: @start)

    date = @start
    date += 1 while NonWorkingDay.find_by(date: date)
    loaded_quotes.find_by(date: date)
  end

  def last_working_day_loaded?(loaded_quotes)
    return true if loaded_quotes.find_by(date: @end)

    date = @end
    date -= 1 while NonWorkingDay.find_by(date: date)
    loaded_quotes.find_by(date: date)
  end
end
