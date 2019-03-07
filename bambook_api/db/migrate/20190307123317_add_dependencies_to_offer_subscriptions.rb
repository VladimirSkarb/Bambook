class AddDependenciesToOfferSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :offer_subscriptions, :user, foreign_key: true
    add_reference :offer_subscriptions, :offer, foreign_key: true
  end
end
