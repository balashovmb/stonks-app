require 'rails_helper'

RSpec.describe FavoriteStockPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }

  let!(:favorite_stock) { create(:favorite_stock, user: user) }

  permissions ".scope" do
    let(:scope) { Pundit.policy_scope!(user, FavoriteStock) }
    it 'allows to list users favorite stocks' do
      expect(scope.to_a).to match_array([favorite_stock])
    end
  end

  permissions :create? do
    it 'allows to create favorite stock' do
      expect(subject).to permit(user, create(:favorite_stock, stock: Stock.last))
    end
  end

  permissions :destroy? do
    it 'allows to create favorite stock' do
      expect(subject).to permit(user, favorite_stock.destroy)
    end
  end
end
