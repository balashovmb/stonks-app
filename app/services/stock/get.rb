class Stock::Get < Service
  def initialize(ticker, options = {})
    @ticker = ticker
    @quotes_expiration_time = options[:quotes_expiration_time] || 1.minute
  end

  def call
    return Failure(message: 'Ticker field is empty') if ticker.empty?
    return Failure(message: 'Ticker must consist of Latin characters') if find_non_latin

    from_database = get_from_database

    return Success(from_database) if from_database

    data = Stock::FetchData.call(ticker)
    Stock::ConvertData.call(**data)
  end

  private

  attr_reader :ticker, :quotes_expiration_time

  def find_non_latin
    ascii_codes = Array(65..90) + Array(97..122) + [44]
    ticker.codepoints.find { |point| !ascii_codes.include?(point) }
  end

  def get_from_database
    res = { source: "database", stocks: {} }

    ticker.split(",").each do |t|
      stock = Stock.find_by(ticker: t.upcase)

      return nil unless stock

      current_price_updated_age = Time.zone.now - stock.current_price_updated_at
      return nil unless current_price_updated_age < quotes_expiration_time

      res[:stocks].merge!({ stock.ticker.upcase.to_sym => stock })
    end
    res
  end
end
