class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :deals
  has_many :trade_positions

  def change_cash_volume(params)
    summ = params[:summ].to_i
    summ_in_cent = summ * 100
    case params[:operation]
    when 'deposite'
      update(cash: self.cash += summ_in_cent)
      "You added #{summ} $ to deposite"
    when 'widthdraw'
      return "You don't have that much cash" if self.cash < summ_in_cent

      update(cash: self.cash -= summ_in_cent)
      "You have withdrawn #{summ} $"
    end
  end
end
