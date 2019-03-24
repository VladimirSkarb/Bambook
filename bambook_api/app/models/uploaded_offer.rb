class UploadedOffer < ApplicationRecord
  has_many :uploaded_offer_owners, dependent: :destroy
  belongs_to :offer
  mount_uploader :book_file, OfferUploader
end
