class StocksController < ApplicationController
  def index
    tickers = Stock.all.map { |stock| stock.ticker }.sort.join(',')
    @stocks = Stocks::Get.call(tickers) || [] unless tickers.empty?
  end

  def get_quote
    @ticker = params[:ticker]
    return unless @ticker

    stock_with_props = Stock.get_and_create_stock(@ticker)
    @stock_props = stock_with_props[:data]
    @not_found = true if @ticker && !@stock_props

    stock = stock_with_props[:stock]
    @deal = stock.deals.new if stock
  end
end
