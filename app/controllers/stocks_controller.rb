class StocksController < ApplicationController
  def index
    tickers = Stock.all.map(&:ticker).sort.join(',')
    stocks_with_metadata = Stock::Get.call(tickers) unless tickers.empty?
    @stocks = stocks_with_metadata[:stocks] if stocks_with_metadata&.dig(:stocks)
  end

  def get_quote
    @ticker = params[:ticker]
    return unless @ticker
    return redirect_to '/stocks/get_quote', alert: 'Ticker field is empty' if @ticker&.empty?

    stocks_with_metadata = Stock.get_and_create_stock(@ticker)

    if stocks_with_metadata&.dig(:data, :errors)
      return redirect_to '/stocks/get_quote', alert: stocks_with_metadata&.dig(:data, :error_message)
    end

    @stock_props = stocks_with_metadata[:data][:stocks].first[1]

    stock = stocks_with_metadata[:stock]
    @deal = stock.deals.new if stock
  end
end
