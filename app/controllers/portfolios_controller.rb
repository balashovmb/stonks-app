class PortfoliosController < ApplicationController
  before_action :authenticate_user!, only: %i[show get_or_add_cash]
  after_action :verify_authorized

  def show
    authorize current_user.portfolio

    @portfolio_report = Portfolio::CreateReport.call(current_user.portfolio)
  end

  def get_or_add_cash
    portfolio = current_user.portfolio

    authorize portfolio

    result = Portfolio::GetOrAddCash.call(portfolio, params)

    redirect_to '/portfolio', result_message(result)
  end
end
