ActiveAdmin.register BalanceRecharge do
  scope :uncorfirmed
  scope :corfirmed
  scope :rejected

  member_action :confirm_recharge, :method=>:get do
  end

  member_action :reject_recharge, :method=>:get do
  end

  action_item :recharge, only: :show do
    link_to 'Confirm recharge ', confirm_recharge_admin_balance_recharge_path
  end

  action_item :reject, only: :show do
    link_to 'Reject recharge ', reject_recharge_admin_balance_recharge_path
  end

  controller do
    def confirm_recharge
      recharge = BalanceRecharge.find(params[:id])
      updated_avaliable_balance = recharge.wallet.available_money += recharge.amount
      recharge.update(status: 1)
      recharge.wallet.update(available_money: updated_avaliable_balance)
      CreateTransaction.call(user: recharge.wallet.user, operation_code: 0, offer_contribution: updated_avaliable_balance)
      redirect_to admin_balance_recharge_url(recharge), notice: "Recharge was confirmed!"
    end

    def reject_recharge
      recharge = BalanceRecharge.find(params[:id])
      recharge.update(status: 2)
      redirect_to admin_balance_recharge_url(recharge), notice: "Recharge was not confirmed!"
    end
  end

  show do
    attributes_table do
    row :status
    row :amount
    row :email
    row :created_at
    end
  end

  end
