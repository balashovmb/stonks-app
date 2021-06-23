require 'rails_helper'

RSpec.describe TradePosition, type: :model do
  it { should belong_to(:portfolio) }
  it { should belong_to(:stock) }
end
