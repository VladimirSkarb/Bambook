module ApiBambook
  module Entities
    class UploadedOffersEntity < Grape::Entity
      expose :offer
      expose :id
      expose :book_file
      expose :offer_id
      expose :created_at
      expose :updated_at
    end
  end
end
