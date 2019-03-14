class AddDependenciesToWallets < ActiveRecord::Migration[5.2]
  def change
    add_reference :wallets, :user, foreign_key: true
  end
end
