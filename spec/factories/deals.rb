FactoryBot.define do
  factory :deal do
    stock
    price { 999 }
    volume { 1 }
    direction { 'long' }
  end
end
