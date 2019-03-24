class UploadedOfferOwner < ApplicationRecord
  belongs_to :user
  belongs_to :uploaded_offer
end
