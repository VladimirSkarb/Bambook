class CreateUploadedOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :uploaded_offers do |t|
      t.string :book_file
      t.timestamps
    end
  end
end
