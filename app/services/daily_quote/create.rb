class DailyQuote::Create < Service
  def initialize(stock, options)
    @stock = stock
    @options = options
  end

  def call
    data = DailyQuote::FetchFromTradier.call(stock, options)
    DailyQuote::CreateFromApiData.call(data, options.merge(stock: stock))
  end

  private

  attr_reader :stock, :options
end
