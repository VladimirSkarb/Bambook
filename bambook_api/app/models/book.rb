class Book < ApplicationRecord
  validates :title, :author, :description, presence: true
  has_one_attached :cover_photo
end
