class AddColumnsToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :avatar, :string
    add_column :offers, :title, :string
    add_column :offers, :author, :string
    add_column :offers, :price, :integer
  end
end
