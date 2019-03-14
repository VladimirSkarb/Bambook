class Offer < ApplicationRecord
  belongs_to :user
  has_many :offer_subscriptions, dependent: :destroy
  validates :deadline, :link, :minimum_quantity, :avatar, :author, :price, :title, presence: true

  enum status: {
    waiting: 0,
    closed: 1,
    purchase: 2,
    sent: 3
  }
end
