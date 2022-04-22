class DailyQuote::PrepareChartProps < Service
  def initialize(stock, options = {})
    @stock = stock
    @refresh_rate = options[:refresh_rate] || 60
  end

  def call
    daily_quotes = DailyQuote::LoadOrCreate.call(stock)
    daily_closes = daily_quotes.pluck(:close)

    quotes_range = daily_closes.max - daily_closes.min
    indent = quotes_range / 5
    max_scale = (daily_closes.max + indent) / 100.to_f
    min_scale = (daily_closes.min - indent) / 100.to_f
    { min_scale: min_scale, max_scale: max_scale, refresh_rate: refresh_rate }
  end

  private

  attr_reader :stock, :refresh_rate
end
