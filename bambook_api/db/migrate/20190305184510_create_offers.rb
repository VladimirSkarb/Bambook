class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.date :deadline
      t.string :link
      t.integer :minimum_quantity
      t.timestamps
    end
  end
end

