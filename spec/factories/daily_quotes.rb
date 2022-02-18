FactoryBot.define do
  sequence :open do |n|
    10000 + n * 100
  end

  sequence :close do |n|
    10100 + n * 100
  end

  sequence :low do |n|
    9900 + n * 100
  end

  sequence :high do |n|
    10200 + n * 100
  end

  sequence :date do |n|
    (Time.zone.today - n).to_s
  end

  factory :daily_quote do
    stock
    date
    low
    high
    open
    close
  end
end
