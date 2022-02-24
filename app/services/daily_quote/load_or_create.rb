class DailyQuote::LoadOrCreate < Service
  def initialize(stock, options = {})
    @stock = stock
    @end = options[:end] || week_day_at_end
    @start = options[:start] || week_day_at_start
    @options = options.merge(start: @start, end: @end)
  end

  def call
    loaded_quotes = DailyQuote.where(date: @start..@end, stock: @stock)
    return loaded_quotes.sort_by(&:date) if all_loaded?(loaded_quotes)

    DailyQuote::Create.call(@stock, @options)
    DailyQuote.where(date: @start..@end, stock: @stock).sort_by(&:date)
  end

  private

  def all_loaded?(loaded_quotes)
    loaded_quotes.find_by(date: @start) && loaded_quotes.find_by(date: @end) # TODO: Need to improve
  end

  def week_day_at_end
    last_day = Time.zone.today.yesterday
    return last_day.yesterday if last_day.saturday?
    return last_day - 2 if last_day.sunday?

    last_day
  end

  def week_day_at_start
    start = @end - 30
    return start + 2 if start.saturday?
    return start.tomorrow if start.sunday?

    start
  end
end
