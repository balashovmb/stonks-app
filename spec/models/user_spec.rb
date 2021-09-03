require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_one(:portfolio) }

  describe '.create' do
    it 'creates portfolio' do
      expect do
        User.create(email: 'user@test.ru', password: '123456')
      end.to change(Portfolio, :count).by(1)
    end

    it 'created portfolio belongs to created user' do
      User.create(email: 'user@test.ru', password: '123456')
      expect(User.last.email).to eq 'user@test.ru'
    end
  end
end
