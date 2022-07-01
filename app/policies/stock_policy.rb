class StockPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    true
  end

  def trading?
    index?
  end

  def daily_quotes?
    index?
  end

  def subscribe_on_quotes?
    index?
  end
end
