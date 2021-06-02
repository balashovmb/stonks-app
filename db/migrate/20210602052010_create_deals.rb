class CreateDeals < ActiveRecord::Migration[6.1]
  def change
    create_table :deals do |t|
      t.references :stock, null: false, foreign_key: true
      t.integer :price, null: false
      t.integer :volume, null: false
      t.integer :direction, null: false

      t.timestamps
    end
  end
end
