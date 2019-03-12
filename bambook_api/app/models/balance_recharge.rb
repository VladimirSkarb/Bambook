class BalanceRecharge < ApplicationRecord
  belongs_to :wallet

  enum status: {
    uncorfirmed: 0,
    corfirmed: 1,
    rejected: 2
  }
end
