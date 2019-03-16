class Offer < ApplicationRecord
  belongs_to :user
  has_many :offer_subscriptions, dependent: :destroy
  validates :deadline, :link, :minimum_quantity, :avatar, :author, :price, :title, presence: true

  scope :waiting_offers, -> { where('deadline < ? and status = ?', Date.today, 0) }
  scope :waiting, -> { where(status: 0) }
  scope :purchase, -> { where(status: 2) }
  scope :closed, -> { where(status: 1) }
  scope :sent, -> { where(status: 3) }

  def self.offers_to_confirm
    waiting_offers = self.waiting_offers
    offers_to_confirm = waiting_offers.select { |offer| offer.minimum_quantity <= offer.offer_subscriptions.count }.map(&:id)
    where(id: offers_to_confirm)
  end

  enum status: {
    waiting: 0,
    closed: 1,
    purchase: 2,
    sent: 3
  }
end
