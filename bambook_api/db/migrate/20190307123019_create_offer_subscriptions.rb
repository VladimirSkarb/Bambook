class CreateOfferSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_subscriptions do |t|
      t.timestamps
    end
  end
end
