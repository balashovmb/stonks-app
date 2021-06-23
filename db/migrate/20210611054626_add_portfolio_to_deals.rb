class AddPortfolioToDeals < ActiveRecord::Migration[6.1]
  def change
    add_reference :deals, :portfolio, null: false, foreign_key: true
  end
end
