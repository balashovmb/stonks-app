class AddCurrentPriceToStock < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :current_price, :integer, null: false
    add_column :stocks, :current_price_updated_at ,:datetime
  end
end
