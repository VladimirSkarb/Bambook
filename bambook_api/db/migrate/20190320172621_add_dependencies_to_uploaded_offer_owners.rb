class AddDependenciesToUploadedOfferOwners < ActiveRecord::Migration[5.2]
  def change
    add_reference :uploaded_offer_owners, :uploaded_offer, foreign_key: true
    add_reference :uploaded_offer_owners, :user, foreign_key: true
  end
end
