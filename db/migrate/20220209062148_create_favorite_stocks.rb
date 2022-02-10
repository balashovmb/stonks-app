class CreateFavoriteStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_stocks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true

      t.timestamps
    end
    add_index :favorite_stocks, [:user_id, :stock_id], unique: true
  end
end
