class AddTickerIndexToSubscribedQuote < ActiveRecord::Migration[6.1]
  def change
    add_index :subscribed_quotes, :ticker, unique: true
  end
end
