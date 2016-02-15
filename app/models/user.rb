class User < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true
  validates :name, length: { maximum: 20 }
  validates :email, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, if: ->(u) { u.email.present? }

  # passwordとpassword_confirmationのチェック
  has_secure_password
end
