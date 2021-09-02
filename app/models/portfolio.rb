class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :deals
  has_many :trade_positions

  validates :cash, numericality: { greater_than_or_equal_to: 0 }

  def get_or_add_cash(params)
    summ = params[:summ].to_f
    summ_in_cent = Money::ConvertToStorageFormat.call(summ)
    operation = params[:operation]
    return { success: false, message: 'Please select the operation' } unless operation

    case operation
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
