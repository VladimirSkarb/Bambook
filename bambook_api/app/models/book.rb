class Book < ApplicationRecord
  validates :title, :author, :description, presence: true
  belongs_to :user
  has_many :reviews, dependent: :destroy

  mount_uploader :cover_photo, CoverPhotoUploader
  mount_uploader :book_file, BookUploader
end
