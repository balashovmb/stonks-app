require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { is_expected.to validate_presence_of(:ticker) }
end
