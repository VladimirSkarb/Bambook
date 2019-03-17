ActiveAdmin.register Offer do
  permit_params :price, :status

  scope :offers_to_confirm
  scope :waiting
  scope :purchase
  scope :closed
  scope :sent

  member_action :confirm_offer, :method=>:get do
  end

  action_item :confirm, only: :show do
    link_to 'Confirm Offer', confirm_offer_admin_offer_path
  end

  controller do

    def confirm_offer
      offer = Offer.includes(:offer_subscriptions, :user).find(params[:id])
      offer.update(status: 3)
      current_contribution = ((offer.price / offer.offer_subscriptions.count) * 1.1).round(2)
      returned_money = offer.contribution - current_contribution
      offer_subscriptions = offer.offer_subscriptions.includes(:user)
      offer_subscriptions.each do |subscription|
        # update balance
        updated_freeze_balance = subscription.user.wallet.frozen_money -= offer.contribution
        updated_available_money = subscription.user.wallet.available_money += returned_money
        subscription.user.wallet.update(frozen_money: updated_freeze_balance, available_money: updated_available_money)
        # create money_transactions for return and write_of
        CreateTransaction.call(user: subscription.user, operation_code: 3, offer_contribution: returned_money)
        CreateTransaction.call(user: subscription.user, operation_code: 1, offer_contribution: current_contribution)
      end

      redirect_to admin_offer_url(offer), notice: "Offer was confirmed!"
    end
  end


  index do
    column :avatar do |x|
      image_tag x.avatar, width: 60, height: 80
    end
    column :title
    column :author
    column :status
    column :price
    column :contribution
    column 'min_q', :minimum_quantity
    column :deadline
    column :user_id
    column :subscribers do |product|
      product.offer_subscriptions.count
    end
    actions
  end

  show do |subscriptions|

    panel 'Subscriptions' do
      table_for offer.offer_subscriptions do |t|
        t.column :id
        t.column :user
        t.column :offer_id
      end
    end

    attributes_table do
      row :title
      row :author
      row :status
      row :price
      row :contribution
      row :minimum_quantity
      row :deadline
      row :user_id
      row :link
      row :avatar do
        image_tag subscriptions.avatar
      end
    end
  end

  filter :deadline
end
