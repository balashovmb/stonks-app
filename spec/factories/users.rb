FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password { '12345678' }
    password_confirmation { '12345678' }
  end

  factory :user_without_portfolio, class: User do
    before(:create){|user| user.define_singleton_method(:create_portfolio){}}
    email
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
