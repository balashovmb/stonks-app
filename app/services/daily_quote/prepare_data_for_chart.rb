class DailyQuote::PrepareDataForChart < Service
  def initialize(stock)
    @stock = stock
  end

  def call
    daily_quotes = DailyQuote::LoadOrCreate.call(stock)
    daily_closes = daily_quotes.map { |q| [q.date, Money::ConvertToViewFormat.call(q.close)] }
    today_props = Stock::Get.call(stock.ticker)
    daily_closes << [Time.zone.today,
                     Money::ConvertToViewFormat.call(today_props[:stocks][stock.ticker.upcase.to_sym]
                      .current_price)]
  end

  private

  attr_reader :stock
end
