require 'rails_helper'

RSpec.describe TradePosition, type: :model do
  it { is_expected.to belong_to(:portfolio) }
  it { is_expected.to belong_to(:stock) }
end
