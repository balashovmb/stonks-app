require 'rails_helper'

RSpec.describe StocksController, type: :controller do
  describe 'GET #daily_quotes' do
    include_context 'stub_api'
    sign_in_user
    let(:stock) { create(:stock) }

    before { get :daily_quotes, params: { stock_id: stock.id } }

    it 'sends json responce' do
      expect(JSON.parse(response.body)).to include(["2022-01-25", 159.78], ["2022-02-25", 124.61])
    end
  end
end
