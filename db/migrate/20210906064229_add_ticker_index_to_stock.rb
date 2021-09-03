class AddTickerIndexToStock < ActiveRecord::Migration[6.1]
  def change
    add_index :stocks, :ticker, unique: true
  end
end
