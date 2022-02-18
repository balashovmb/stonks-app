class DailyQuote::LoadOrCreate < Service
  def initialize(stock, options = {})
    @stock = stock
    today =  Time.zone.today
    @start = options[:start] || (today - 7)
    @end = options[:end] || (today - 1)
    @options = options
  end

  def call
    loaded_quotes = DailyQuote.where(date: @start..@end, stock: @stock)
    return loaded_quotes.sort_by(&:date) if loaded_quotes.length == number_of_working_days

    DailyQuote::Create.call(@stock, @options)
    DailyQuote.where(date: @start..@end, stock: @stock).sort_by(&:date)
  end

  private

  def number_of_working_days
    (@end - @start).to_i - 1 # TODO: need to improve
  end
end
