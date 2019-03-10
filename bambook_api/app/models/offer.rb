class Offer < ApplicationRecord
  belongs_to :user
  has_many :offer_subscriptions, dependent: :destroy
  validates :deadline, :link, :minimum_quantity, presence: true
end
