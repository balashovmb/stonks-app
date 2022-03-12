class PortfolioPolicy < ApplicationPolicy
  def manage?
    user.id == record.user_id
  end

  def show?
    manage?
  end

  def get_or_add_cash?
    manage?
  end
end
