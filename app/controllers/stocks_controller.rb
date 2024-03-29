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

    stock_props = Stock::Get.call(@ticker)

    if stock_props.failure?
      flash.now[:alert] = stock_props.failure[:message]
      return render trading_stocks_path
    end

    @stock = stock_props.success[:stocks].first.last

    @deals = policy_scope(Deal).where(
      stock: @stock, created_at: Time.zone.today..Time.zone.today + 1
    ).last(10).reverse if @stock && user_signed_in?

    @chart_props = DailyQuote::PrepareChartProps.call(@stock)

    @deal = @stock.deals.new
  end

  def daily_quotes
    authorize Stock
    stock = Stock.find(params[:stock_id])
    BroadcastQuotesJob.perform_now if ENV["DEPLOYED_ON"] == "heroku"
    render json: DailyQuote::PrepareDataForChart.call(stock)
  end

  def subscribe_on_quotes
    authorize Stock
    SubscribedQuote::Create.call(params[:ticker])
    head :no_content
  end

  private

  def load_stocks_list(tickers)
    return nil if tickers.empty?

    stocks_with_metadata = Stock::Get.call(tickers)
    stocks_with_metadata.success[:stocks] if stocks_with_metadata.success? #if stocks_with_metadata&.dig(:stocks)
  end
end
