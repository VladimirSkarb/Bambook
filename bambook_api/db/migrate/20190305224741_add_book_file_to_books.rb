class AddBookFileToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :book_file, :string
  end
end
