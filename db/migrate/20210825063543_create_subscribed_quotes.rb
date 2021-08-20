class CreateSubscribedQuotes < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribed_quotes do |t|
      t.string :ticker, null: false

      t.timestamps
    end
  end
end
