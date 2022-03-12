require 'rails_helper'

RSpec.describe StockPolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions :index? do
    it 'allows to list stocks' do
      expect(subject).to permit(user, Stock.all)
    end
  end
end
