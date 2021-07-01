class StocksController < ApplicationController
  def index
    tickers = Stock.all.map { |stock| stock.ticker }.sort.join(',')
    stocks_with_metadata = Stock::Get.call(tickers) unless tickers.empty?
    @stocks = stocks_with_metadata ? stocks_with_metadata[:stocks] : nil
  end

  def get_quote
    @ticker = params[:ticker]
    return unless @ticker

    stocks_with_metadata = Stock.get_and_create_stock(@ticker)
    @stock_props = stocks_with_metadata[:data][:stocks].first[1]
    @not_found = true if @stock_props[:unmatched_symbols]

    stock = stocks_with_metadata[:stock]
    @deal = stock.deals.new if stock
  end
end
