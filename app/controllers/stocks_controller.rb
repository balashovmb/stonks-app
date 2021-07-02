class StocksController < ApplicationController
  def index
    tickers = Stock.all.map(&:ticker).sort.join(',')
    stocks_with_metadata = Stock::Get.call(tickers) unless tickers.empty?
    @stocks = stocks_with_metadata ? stocks_with_metadata[:stocks] : nil
  end

  def get_quote
    @ticker = params[:ticker]
    return unless @ticker

    stocks_with_metadata = Stock.get_and_create_stock(@ticker)
    return @not_found = true if stocks_with_metadata[:data][:unmatched_symbols]

    @stock_props = stocks_with_metadata[:data][:stocks].first[1]

    stock = stocks_with_metadata[:stock]
    @deal = stock.deals.new if stock
  end
end
