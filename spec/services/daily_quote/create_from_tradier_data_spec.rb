require 'rails_helper'

describe DailyQuote::CreateFromTradierData do
  let(:daily_quotes_json) { File.read(Rails.root.join('spec/data/daily_quotes.json')) }
  let(:stock) { create(:stock) }

  let(:subject) do
    described_class.call({ daily_quotes_json: daily_quotes_json, stock: stock },
                         { start_of_interval: '25-01-2022'.to_date, end_of_interval: '24-02-2022'.to_date })
  end

  it 'creates 22 DailyQuote records from Tradier\'s json' do
    expect { subject }.to change(DailyQuote, :count).by(22)
  end

  it 'creates 9 NonWorkingDay records from Tradier\'s json' do
    expect { subject }.to change(NonWorkingDay, :count).by(9)
  end
end
