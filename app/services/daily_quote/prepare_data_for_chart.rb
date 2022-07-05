class DailyQuote::PrepareDataForChart < Service
  def initialize(stock)
    @stock = stock
  end

  def call
    daily_quotes = DailyQuote::LoadOrCreate.call(stock)
    daily_quotes.map do |q|
      { x: q.date,
        y: [
          Money::ConvertToViewFormat.call(q.open),
          Money::ConvertToViewFormat.call(q.high),
          Money::ConvertToViewFormat.call(q.low),
          Money::ConvertToViewFormat.call(q.close)
        ] }
    end
  end

  private

  attr_reader :stock
end
