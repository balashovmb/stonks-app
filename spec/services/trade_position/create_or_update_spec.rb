require 'rails_helper'

describe TradePosition::CreateOrUpdate do
  let(:portfolio) { create(:portfolio) }
  let(:deal) { build(:deal, portfolio: portfolio) }

  it 'creates TradePosition' do
    expect { deal.save }.to change(TradePosition, :count).by(1)
  end
end
