class AddCoverPhotoToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :cover_photo, :string
  end
end
