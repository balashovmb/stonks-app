class Stock::FetchData < TradierApiBase
  def initialize(ticker)
    @url = URI("https://sandbox.tradier.com/v1/markets/quotes?symbols=#{ticker}")
  end

  private

  attr_reader :url
end
