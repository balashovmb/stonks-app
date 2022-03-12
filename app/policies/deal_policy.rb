class DealPolicy < ApplicationPolicy
  def create?
    user
  end

  class Scope < Scope
    def resolve
      scope.where(portfolio_id: user.portfolio.id)
    end
  end
end
