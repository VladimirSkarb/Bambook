ActiveAdmin.register Offer do
  permit_params :price, :status

  scope :offers_to_confirm
  scope :waiting
  scope :purchase
  scope :closed
  scope :sent

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
