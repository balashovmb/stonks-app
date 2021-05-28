class Stocks::Get < Service
  def initialize(ticker)
    @ticker = ticker
  end

  def call
    return if @ticker.empty?
    
    data = Stocks::FetchData.call(@ticker)
    Stocks::ConvertData.call(data)
  end
end
