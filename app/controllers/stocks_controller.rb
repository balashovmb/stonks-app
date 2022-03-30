class StocksController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Stock

    tickers = Stock.pluck(:ticker).sort.join(',')
    @stocks = load_stocks_list(tickers)
  end

  def trading
    authorize Stock

    if current_user
      tickers = current_user.favorite_stocks.joins(:stock).pluck(:ticker).sort.join(',')
      @stocks = load_stocks_list(tickers)
    end

    @ticker = params[:ticker]
    return unless @ticker

    stock_with_metadata = Stock::GetDataAndCreate.call(@ticker)

    if stock_with_metadata&.dig(:data, :errors)
      flash.now[:alert] = stock_with_metadata&.dig(:data, :error_message)
      return render trading_stocks_path
    end

    @stock_props = stock_with_metadata&.dig(:data, :stocks)&.first&.last

    stock = stock_with_metadata[:stock]
    return unless stock

    @quotes = DailyQuote::LoadOrCreate.call(stock)

    @deal = stock.deals.new
  end

  private

  def load_stocks_list(tickers)
    stocks_with_metadata = Stock::Get.call(tickers) unless tickers.empty?
    stocks_with_metadata[:stocks] if stocks_with_metadata&.dig(:stocks)
  end
end
