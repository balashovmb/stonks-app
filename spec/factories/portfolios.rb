FactoryBot.define do
  factory :portfolio do
    cash { 1000000 }
    association :user, factory: :user_without_portfolio
  end
end
