class StocksController < ApplicationController
  def index
    
  end
  def get_quote
    ticker = params[:ticker]
    @stock_props = Stock.get_quote(ticker)
    render :index
  end
end
