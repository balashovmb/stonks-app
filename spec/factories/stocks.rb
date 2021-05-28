FactoryBot.define do
  factory :stock do
    ticker { 'AAPL' }
  end

  sequence :ticker do |n|
    "Ticker#{n}"
  end

  factory :stocks_list, class: 'Stock' do
    ticker
  end
end
