class PortfoliosController < ApplicationController
  def show
    @portfolio_report = Portfolio::CreateReport.call(current_user.portfolio)
  end

  def get_or_add_cash
    message = current_user.portfolio.get_or_add_cash(params)[:message]
    redirect_to '/portfolio', notice: message
  end
end
