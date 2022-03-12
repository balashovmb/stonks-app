require 'rails_helper'

RSpec.describe PortfolioPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:portfolio) { create(:portfolio, user: user) }

  permissions :show? do
    let(:portfolio2) { create(:portfolio) }
    it 'allows to show users portfolio' do
      expect(subject).to permit(user, portfolio)
    end

    it 'not allows to show another users portfolio' do
      expect(subject).to permit(user, portfolio)
    end
  end
end
