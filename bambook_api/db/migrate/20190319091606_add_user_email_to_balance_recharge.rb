class AddUserEmailToBalanceRecharge < ActiveRecord::Migration[5.2]
  def change
    add_column :balance_recharges, :email, :string
  end
end
