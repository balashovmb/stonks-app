class PortfoliosController < ApplicationController
  def show
    @portfolio = current_user.portfolio
  end

  def change_cash_volume
    message = current_user.portfolio.change_cash_volume(params)
    redirect_to '/portfolio', notice: message
  end
end
