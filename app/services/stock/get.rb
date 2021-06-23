class Stock::Get < Service
  def initialize(ticker)
    @ticker = ticker
  end

  def call
    return if @ticker.empty?
    
    data = Stock::FetchData.call(@ticker)
    Stock::ConvertData.call(data)
  end
end
