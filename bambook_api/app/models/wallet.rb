class Wallet < ApplicationRecord
  belongs_to :user
  has_many :money_transactions, dependent: :destroy
end
