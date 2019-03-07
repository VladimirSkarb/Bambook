class Offer < ApplicationRecord
  belongs_to :user
  has_many :offer_subscriptions, dependent: :destroy
  validates_presence_of :deadline, :link, :minimum_quantity

end
