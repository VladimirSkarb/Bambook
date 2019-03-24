class BalanceRecharge < ApplicationRecord
  belongs_to :wallet

  scope :uncorfirmed, -> { where(status: 0) }
  scope :corfirmed, -> { where(status: 1) }
  scope :rejected, -> { where(status: 2) }

  enum status: {
    uncorfirmed: 0,
    corfirmed: 1,
    rejected: 2
  }
end
