class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_one :portfolio
  has_many :favorite_stocks, dependent: :destroy

  after_create :create_portfolio

  def create_portfolio
    Portfolio.create(user: self, cash: 0)
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    p 'data'
    p data
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
end
end
