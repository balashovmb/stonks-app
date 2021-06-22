FactoryBot.define do
  factory :trade_position do
    stock
    portfolio
    volume { 1 }
    average_price { 1 }
  end
end
