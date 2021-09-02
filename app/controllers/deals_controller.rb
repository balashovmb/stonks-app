class DealsController < ApplicationController
  def show
    @deal = Deal.find(params[:id])
  end

  def create
    @deal = current_user.portfolio.deals.new(deal_params)
    respond_to do |format|
      if @deal.save
        format.js
        format.html { redirect_to @deal, notice: "You bought #{@deal.volume} stocks" }
      else
        format.js
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
