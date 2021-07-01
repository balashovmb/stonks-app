class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :deals
  has_many :trade_positions

  validates :cash, numericality: { greater_than_or_equal_to: 0 }

  def get_or_add_cash(params)
    summ = params[:summ].to_i
    summ_in_cent = summ * 100
    case params[:operation]
    when 'deposite'
      update(cash: self.cash += summ_in_cent)
      { success: true, message: "You added #{summ} $ to deposite" }
    when 'widthdraw'
      return { success: false, message: "You don't have that much cash" } if self.cash < summ_in_cent

      self.cash -= summ_in_cent
      { success: true, message: "You have withdrawn #{summ} $" } if update(cash: cash)
    end
  end
end
