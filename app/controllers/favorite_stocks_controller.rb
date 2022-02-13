class FavoriteStocksController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @stock_id = params[:stock_id]
    current_user.favorite_stocks.create(stock_id: @stock_id)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @stock_id = params[:id]
    favorite_stock = current_user.favorite_stocks.find_by(stock_id: @stock_id)
    favorite_stock.destroy
    respond_to do |format|
      format.js
    end
  end
end
