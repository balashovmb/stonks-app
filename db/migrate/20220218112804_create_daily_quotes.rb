class CreateDailyQuotes < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_quotes do |t|
      t.references :stock, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :low, null: false
      t.integer :high, null: false
      t.integer :open, null: false
      t.integer :close, null: false

      t.timestamps
    end
    add_index :daily_quotes, [:stock_id, :date], unique: true
  end
end
