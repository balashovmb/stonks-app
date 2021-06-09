class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      t.integer :cash
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
