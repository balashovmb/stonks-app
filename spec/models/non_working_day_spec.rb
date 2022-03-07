require 'rails_helper'

RSpec.describe NonWorkingDay, type: :model do
  it { is_expected.to validate_presence_of(:date) }
end
