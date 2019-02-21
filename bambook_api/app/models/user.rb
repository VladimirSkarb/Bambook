class User < ApplicationRecord
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates_presence_of :email, :password_digest
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEXP
  has_secure_password

  has_many :books, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
