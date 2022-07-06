require 'rails_helper'

describe TradePosition::CreateOrUpdate do
  let(:portfolio) { create(:portfolio) }

  context 'first deal' do
    let(:deal) { build(:deal, portfolio:) }

    it 'creates TradePosition' do
      expect { deal.save }.to change(TradePosition, :count).by(1)
    end
  end

  context 'second oposite deal' do
    let!(:deal) { create(:deal, portfolio:) }
    let(:deal2) do
      build(:deal, portfolio:, direction: 'short', volume: 3, stock: Stock.first)
    end

    it 'changes the direction of a TradePosition' do
      expect { deal2.save }.to change { TradePosition.first.direction }.from('long').to('short')
    end

    it 'changes the volume of a TradePosition' do
      expect { deal2.save }.to change { TradePosition.first.volume }.from(1).to(2)
    end

    it 'does not change the average TradePosition price (because the price is the same)' do
      expect { deal2.save }.not_to change { TradePosition.first.average_price }
    end
  end
end
