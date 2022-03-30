require 'rails_helper'

describe Portfolio::GetOrAddCash do
  let(:portfolio) { create(:portfolio) }

  it 'adds cash' do
    Portfolio::GetOrAddCash.call(portfolio, { operation: 'deposite', summ: 1000 })
    expect(portfolio.cash).to eq 1100000
  end

  it 'widthdraws cash' do
    Portfolio::GetOrAddCash.call(portfolio, { operation: 'widthdraw', summ: 1000 })
    expect(portfolio.cash).to eq 900000
  end
end
