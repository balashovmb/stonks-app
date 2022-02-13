class DealsController < ApplicationController
  before_action :authenticate_user!, only: %i[create index show]

  def show
    @deal = Deal.find(params[:id])
  end

  def create
    @deal = current_user.portfolio.deals.new(deal_params)
    respond_to do |format|
      format.js
      if @deal.save
        format.html { redirect_to @deal, notice: "You bought #{@deal.volume} stocks" }
      else
        format.html { render :new }
      end
    end
  end

  def index
    @deals = current_user.portfolio.deals.includes(:stock)
  end

  private

  def deal_params
    result = params.require(:deal).permit(:price, :direction, :volume, :stock_id)
    result[:price] = Money::ConvertToStorageFormat.call(result[:price])
    result
  end
end
