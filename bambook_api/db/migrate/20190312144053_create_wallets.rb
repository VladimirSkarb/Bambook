class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.integer :available_money, :default => 0
      t.integer :frozen_money, :default => 0
      t.timestamps
    end
  end
end
