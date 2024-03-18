class Portfolio::GetOrAddCash < Service
  def initialize(portfolio, params)
    @portfolio = portfolio
    @params = params
    @operation = params[:operation]
    @summ = params[:summ].to_f
  end

  def call
    return Failure(message: 'Please select the operation') unless operation

    return Failure(message: 'Please input positive amount') unless summ.positive?

    perform_operation
  end

  private

  attr_reader :portfolio, :params, :operation, :summ

  def perform_operation
    summ_in_cent = Money::ConvertToStorageFormat.call(summ)
    case operation
    when 'deposite'
      deposite(summ_in_cent)
    when 'widthdraw'
      widthdraw(summ_in_cent)
    end
  end

  def deposite(summ_in_cent)
    new_cash = portfolio.cash + summ_in_cent
    portfolio.update(cash: new_cash)
    Success(message: "You have deposited #{summ} $")
  end

  def widthdraw(summ_in_cent)
    return Failure(message: "You don't have enough cash") if portfolio.cash < summ_in_cent

    new_cash = portfolio.cash - summ_in_cent
    return unless portfolio.update(cash: new_cash)

    Success(message: "You have withdrawn #{summ} $")
  end
end
