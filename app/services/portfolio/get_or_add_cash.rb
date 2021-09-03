class Portfolio::GetOrAddCash < Service
  def initialize(portfolio, params)
    @portfolio = portfolio
    @params = params
  end

  def call
    summ = @params[:summ].to_f
    summ_in_cent = Money::ConvertToStorageFormat.call(summ)
    operation = @params[:operation]
    return { success: false, message: 'Please select the operation' } unless operation
    return { success: false, message: 'Please input positive amount' } unless summ > 0

    case operation
    when 'deposite'
      new_cash = @portfolio.cash + summ_in_cent
      @portfolio.update(cash: new_cash)
      { success: true, message: "You added #{summ} $ to deposite" }
    when 'widthdraw'
      return { success: false, message: "You don't have that much cash" } if @portfolio.cash < summ_in_cent

      new_cash = @portfolio.cash - summ_in_cent
      { success: true, message: "You have withdrawn #{summ} $" } if @portfolio.update(cash: new_cash)
    end
  end
end
