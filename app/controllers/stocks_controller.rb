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

    stock_props_and_history = Stock::GetPropsAndDailyQuotes.call(@ticker)

    if stock_props_and_history[:error_message]
      flash.now[:alert] = stock_props_and_history[:error_message]
      return render trading_stocks_path
    end

    @stock_props = stock_props_and_history[:stock_props]

    @quotes = stock_props_and_history[:quotes]

    @deal = stock_props_and_history&.dig(:stock)&.deals&.new
  end

  private

  def load_stocks_list(tickers)
    stocks_with_metadata = Stock::Get.call(tickers) unless tickers.empty?
    stocks_with_metadata[:stocks] if stocks_with_metadata&.dig(:stocks)
  end
end
