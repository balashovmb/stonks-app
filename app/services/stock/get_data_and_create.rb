class Stock::GetDataAndCreate < Service
  def initialize(ticker)
    @ticker = ticker
  end

  def call
    data = Stock::Get.call(@ticker)
    stock = Stock.find_or_create_by(ticker: @ticker.upcase) unless data&.dig(:errors)
    { data: data, stock: stock }
  end
end
