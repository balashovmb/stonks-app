require 'rails_helper'

RSpec.describe SubscribedQuote, type: :model do
  it { is_expected.to validate_presence_of(:ticker) }
end
