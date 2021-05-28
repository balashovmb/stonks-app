class StocksController < ApplicationController
  def index
    tickers = Stock.all.map{|stock| stock.ticker}.sort.join(',')
    unless tickers.empty?
      @stocks = Stocks::Get.call(tickers) || []
    end
  end

  def get_quote
    @ticker = params[:ticker]
    @stock_props = Stock.get_quote(@ticker) if @ticker
    @not_found = true if @ticker && !@stock_props
  end
end
