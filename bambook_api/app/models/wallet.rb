class Wallet < ApplicationRecord
  belongs_to :user
  has_many :money_transactions, dependent: :destroy
  has_many :balance_recharges, dependent: :destroy
end
