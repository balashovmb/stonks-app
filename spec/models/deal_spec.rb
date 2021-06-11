require 'rails_helper'

RSpec.describe Deal, type: :model do
  describe '#checkout' do
    let(:user) { create :user }
    let!(:portfolio) { create :portfolio, user: user }
    let(:deal) { build(:deal, portfolio: portfolio) }
    it 'withdraws money' do
      expect { deal.save }.to change{ user.portfolio.cash }.by(-999)
    end
  end
end
