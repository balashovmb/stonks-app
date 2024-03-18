class Portfolio::GetOrAddCash < Service
  def initialize(portfolio, params)
    @portfolio = portfolio
    @params = params
    @operation = params[:operation]
    @sum = params[:sum].to_f
  end

  def call
    return Failure(message: 'Please select the operation') unless operation

    return Failure(message: 'Please input positive amount') unless sum.positive?

    perform_operation
  end

  private

  attr_reader :portfolio, :params, :operation, :sum

  def perform_operation
    sum_in_cent = Money::ConvertToStorageFormat.call(sum)
    case operation
    when 'deposite'
      deposite(sum_in_cent)
    when 'widthdraw'
      widthdraw(sum_in_cent)
    end
  end

  def deposite(sum_in_cent)
    new_cash = portfolio.cash + sum_in_cent
    portfolio.update(cash: new_cash)
    Success(message: "You have deposited #{sum} $")
  end

  def widthdraw(sum_in_cent)
    return Failure(message: "You don't have enough cash") if portfolio.cash < sum_in_cent

    new_cash = portfolio.cash - sum_in_cent
    return unless portfolio.update(cash: new_cash)

    Success(message: "You have withdrawn #{sum} $")
  end
end
