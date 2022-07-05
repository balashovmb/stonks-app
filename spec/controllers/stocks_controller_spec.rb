require 'rails_helper'

RSpec.describe StocksController, type: :controller do
  describe 'GET #daily_quotes' do
    include_context 'stub_api'
    sign_in_user
    let(:stock) { create(:stock) }

    before { get :daily_quotes, params: { stock_id: stock.id } }

    it 'sends json responce' do
      expect(JSON.parse(response.body)).to include(
        {"x" => "2022-01-25", "y" => [158.97, 162.76, 157.02, 159.78]},
        {"x" => "2022-02-24", "y" => [152.58, 162.85, 152.0, 162.74]}
      )
    end
  end
end
