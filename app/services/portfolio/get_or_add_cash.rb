class Portfolio::GetOrAddCash < Service
  def initialize(portfolio, params)
    @portfolio = portfolio
    @params = params
    @operation = params[:operation]
    @summ = params[:summ].to_f
  end

  def call
    return { message: 'Please select the operation', message_type: :alert } unless operation

    return { message: 'Please input positive amount', message_type: :alert } unless summ.positive?

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
    { message: "You added #{summ} $ to deposite", message_type: :notice }
  end

  def widthdraw(summ_in_cent)
    if portfolio.cash < summ_in_cent
      return { message: "You don't have that much cash", message_type: :alert }
    end

    new_cash = portfolio.cash - summ_in_cent
    return unless portfolio.update(cash: new_cash)

    { message: "You have withdrawn #{summ} $", message_type: :notice }
  end
end
