class PortfoliosController < ApplicationController
  before_action :authenticate_user!, only: %i[show get_or_add_cash]

  def show
    @portfolio_report = Portfolio::CreateReport.call(current_user.portfolio)
  end

  def get_or_add_cash
    result = current_user.portfolio.get_or_add_cash(params)
    message = if result[:success]
                { notice: result[:message] }
              else
                { alert: result[:message] }
              end
    redirect_to '/portfolio', message
  end
end
