class Book < ApplicationRecord
  validates :title, :author, :description, presence: true
  has_one_attached :cover_photo
  has_one_attached :book_file

  def product_image_url
    Rails.application.routes.url_helpers.url_for(cover_photo) if cover_photo.attached?
  end

  def download_book_url
    Rails.application.routes.url_helpers.url_for(book_file) if book_file.attached?
  end
end
