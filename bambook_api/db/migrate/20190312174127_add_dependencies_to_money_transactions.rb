class AddDependenciesToMoneyTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :money_transactions, :wallet, foreign_key: true
  end
end
