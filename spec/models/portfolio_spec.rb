require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  it { should belong_to(:user) }

  describe '#change_cash_volume' do
    let(:portfolio) { create(:portfolio) }
    it 'adds cash' do
      portfolio.change_cash_volume(operation: 'deposite', summ: 1000)
      expect(portfolio.cash).to eq 200000
    end
    it 'widthdraws cash' do
      portfolio.change_cash_volume(operation: 'widthdraw', summ: 1000)
      expect(portfolio.cash).to eq 0
    end
  end
end
