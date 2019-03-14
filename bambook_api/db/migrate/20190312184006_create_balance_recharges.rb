class CreateBalanceRecharges < ActiveRecord::Migration[5.2]
  def change
    create_table :balance_recharges do |t|
      t.integer :amount, :default => 0
      t.integer :status, :default => 0
      t.timestamps
    end
  end
end
