class CreateMoneyTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :money_transactions do |t|
      t.integer :amount
      t.integer :operation
      t.timestamps
    end
  end
end
