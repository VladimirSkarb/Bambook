class CreateUploadedOfferOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :uploaded_offer_owners do |t|

      t.timestamps
    end
  end
end
