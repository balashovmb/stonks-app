require 'rails_helper'

RSpec.describe DealPolicy, type: :policy do
  subject { described_class }

  let!(:portfolio) { create(:portfolio) }

  permissions ".scope" do
    let(:scope) { Pundit.policy_scope!(portfolio.user, Deal) }
    let!(:deal) { create(:deal, portfolio: portfolio) }
    let(:portfolio2) { create(:portfolio) }
    let(:deal2) { create(:deal, portfolio: portfolio2, stock: deal.stock) }
    it 'allows to list users deals' do
      expect(scope.to_a).to match_array([deal])
    end

    it 'not allows to list another users deals' do
      expect(scope.to_a).not_to include(deal2)
    end
  end

  permissions :create? do
    it "grants acces to any user with portfolio" do
      expect(subject).to permit(portfolio.user, create(:deal, portfolio: portfolio))
    end
  end
end
