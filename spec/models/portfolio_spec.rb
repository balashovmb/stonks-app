require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  it { is_expected.to belong_to(:user) }

  describe '#change_cash_volume' do
    let(:portfolio) { create(:portfolio) }

    it 'adds cash' do
      portfolio.get_or_add_cash(operation: 'deposite', summ: 1000)
      expect(portfolio.cash).to eq 1100000
    end

    it 'widthdraws cash' do
      portfolio.get_or_add_cash(operation: 'widthdraw', summ: 1000)
      expect(portfolio.cash).to eq 900000
    end
  end
end
