class MoneyTransaction < ApplicationRecord
  belongs_to :wallet

  enum operation: {
    recharge: 0,
    write_off: 1,
    reserve: 2,
    returned: 3
  }
end
