require 'rails_helper'

RSpec.describe DailyQuote, type: :model do
  it { is_expected.to belong_to(:stock) }
end
