class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :tweet

  def self.find_for_twitter_oauth(auth)
    user = User.find_by(uid: auth.uid)
    return user if user.present?
    user = User.create!(uid: auth.uid, provider: auth.provider, name: auth.info.nickname,
                        credentials_token: auth.credentials.token,
                        credentials_secret: auth.credentials.secret,
                        password: Devise.friendly_token[0, 20],
                        email: 'no@gmail.com')
  end
end
