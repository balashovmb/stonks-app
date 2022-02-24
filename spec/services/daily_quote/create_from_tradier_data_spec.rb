require 'rails_helper'

describe DailyQuote::CreateFromTradierData do
  let(:daily_quotes_json) { File.read(Rails.root.join('spec/data/daily_quotes.json')) }
  let(:stock) { create(:stock) }

  let(:subject) { described_class.call(daily_quotes_json: daily_quotes_json, stock: stock) }

  it 'converts one stock data from Tradier' do
    expect {subject}.to change(DailyQuote, :count).by(22)
  end
end
