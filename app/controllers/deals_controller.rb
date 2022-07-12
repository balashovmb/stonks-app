class DealsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: %i[create index]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def create
    @deal = current_user.portfolio.deals.new(deal_params)

    authorize @deal

    respond_to do |format|
      if @deal.save
        format.html { redirect_to trading_stocks_url(ticker: @deal.stock.ticker) }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            @deal, partial: 'deals/deal_form', locals: { deal: @deal }
          )
        end
        format.html { render :new }
      end
    end
  end

  def index
    @pagy, @deals = pagy(policy_scope(Deal).includes(:stock).order(created_at: :desc))
  end

  private

  def deal_params
    result = params.require(:deal).permit(:price, :direction, :volume, :stock_id)
    stock = Stock.find(result[:stock_id])
    result[:price] = stock.current_price
    result
  end
end
