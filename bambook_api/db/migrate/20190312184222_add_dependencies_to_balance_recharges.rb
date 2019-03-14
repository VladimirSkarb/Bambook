class AddDependenciesToBalanceRecharges < ActiveRecord::Migration[5.2]
  def change
    add_reference :balance_recharges, :wallet, foreign_key: true
  end
end
