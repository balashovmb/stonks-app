require 'rails_helper'

RSpec.describe Deal, type: :model do
  let(:user) { create :user }
  let!(:portfolio) { create :portfolio, user: user }
  let(:stock) { create :stock }
  let(:deal) { build(:deal, portfolio: portfolio, stock: stock) }
  describe '#checkout' do
    let(:short_deal) { build(:deal, portfolio: portfolio, stock: stock, direction: 'short') }
    it 'withdraws money' do
      expect { deal.save }.to change{ user.portfolio.cash }.by(-999)
    end
    it 'adds money' do
      expect { short_deal.save }.to change{ user.portfolio.cash }.by(999)
    end
  end
  describe '.create' do
    it 'calls create of update trade position service' do
      expect(TradePositions::CreateOrUpdate).to receive(:call)
      deal.save
    end
    context 'first deal with stock' do
      it 'creates TradePosition' do
        expect { deal.save }.to change { TradePosition.count }.by(1)
      end
    end
    context 'second deal with same stock' do
      context 'deal size eq stock position size' do
        let(:oposite_deal) { build(:deal, portfolio: portfolio, stock: stock, direction: 'short') }
        it 'deletes TradePosition ' do
          deal.save
          expect { oposite_deal.save }.to change { TradePosition.count }.by(-1)
        end
      end
      context 'deal size less then the stock position size' do
        let!(:deal) { create(:deal, portfolio: portfolio, stock: stock, volume: 2) }
        let(:oposite_deal) { build(:deal, portfolio: portfolio, stock: stock, direction: 'short') }
        it 'changes TradePosition volume' do
          expect { oposite_deal.save }.to change { portfolio.trade_positions.last.volume }.by(-1)
        end
      end
      context 'deal size more then the stock position size' do
        let!(:deal) { create(:deal, portfolio: portfolio, stock: stock, volume: 1) }
        let(:oposite_deal) { build(:deal, portfolio: portfolio, stock: stock, direction: 'short', volume: 3) }
        it 'changes TradePosition direction' do
          expect { oposite_deal.save }.to change { portfolio.trade_positions.last.direction }.from('long').to('short')
        end
      end
    end
  end
end
