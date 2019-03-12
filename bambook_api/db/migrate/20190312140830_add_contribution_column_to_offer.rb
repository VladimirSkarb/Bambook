class AddContributionColumnToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :contribution, :integer
  end
end
