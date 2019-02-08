class Book < ApplicationRecord
  validates :title, :author, :description, presence: true
  has_one_attached :cover_photo
  has_one_attached :book_file
end
