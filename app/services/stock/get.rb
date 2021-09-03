class Stock::Get < Service
  def initialize(ticker)
    @ticker = ticker
  end

  def call
    return { errors: true, error_message: 'Ticker field is empty' } if @ticker.empty?
    if find_non_latin
      return { errors: true, error_message: 'Ticker must consist of Latin characters' }
    end

    data = Stock::FetchData.call(@ticker)
    Stock::ConvertData.call(data)
  end

  private

  def find_non_latin
    ascii_codes = Array(65..90) + Array(97..122) + [44]
    @ticker.codepoints.find { |point| !ascii_codes.include?(point) }
  end
end
