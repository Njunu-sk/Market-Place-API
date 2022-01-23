class User < ApplicationRecord
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :password_digest, presence: true

  has_secure_password
  has_many :products, dependent: :destroy
end
