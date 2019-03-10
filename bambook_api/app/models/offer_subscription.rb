class OfferSubscription < ApplicationRecord
  belongs_to :offer
  belongs_to :user
  validates :offer_id, :user_id, presence: true
end
