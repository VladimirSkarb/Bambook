class AddOfferIdToUploadedOffer < ActiveRecord::Migration[5.2]
  def change
    add_reference :uploaded_offers, :offer, foreign_key: true
  end
end
