class Book < ApplicationRecord
  validates :title, :author, :description, presence: true
  belongs_to :user
  has_many :reviews

  has_one_attached :cover_photo
  has_one_attached :book_file

  def attachment_manager(params, book)
    begin
      uploaded_book_file = File.open(params[:book_file][:tempfile].path)
      cover_photo = image_converter(File.open(params[:cover_photo][:tempfile].path))
      book.cover_photo.attach(io: File.open(cover_photo.path), filename: cover_photo.path.split('/').last)
      book.book_file.attach(io: uploaded_book_file, filename: params[:book_file][:filename])
    rescue
      { status: 'The book or cover photo was not upload. Please doublecheck it' }
    end

  end

  def product_image_url
    image_url_for(cover_photo)
  end

  def download_book_url
    image_url_for(book_file)
  end

  private

  def image_converter(uploaded_cover_photo)
    image = MiniMagick::Image.open(uploaded_cover_photo)
    image.resize "320x240"
  end

  def image_url_for(attachment)
    Rails.application.routes.url_helpers.url_for(attachment) if attachment.attached?
  end
end
