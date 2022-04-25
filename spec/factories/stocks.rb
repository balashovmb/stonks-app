FactoryBot.define do
  factory :stock do
    ticker { 'AAPL' }
    description { 'Apple Inc' }
    current_price { 100 }
    current_price_updated_at { Time.zone.now - 2.minute }
  end

  sequence :ticker do |n|
    "Ticker#{n}"
  end

  factory :stocks_list, class: 'Stock' do
    ticker
    sequence(:description) {"Description #{_1}"}
    current_price { 100 }
    current_price_updated_at { Time.zone.now }
  end
end
