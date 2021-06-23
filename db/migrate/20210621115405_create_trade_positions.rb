class CreateTradePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :trade_positions do |t|
      t.references :stock, null: false, foreign_key: true
      t.references :portfolio, null: false, foreign_key: true
      t.integer :volume, null: false
      t.integer :average_price, null: false
      t.integer :direction, null: false

      t.timestamps
    end
  end
end
