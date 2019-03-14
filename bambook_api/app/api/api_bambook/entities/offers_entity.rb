module ApiBambook
  module Entities
    class OffersEntity < Grape::Entity
      expose :id
      expose :deadline
      expose :link
      expose :minimum_quantity
      expose :user_id
      expose :avatar
      expose :author
      expose :title
      expose :price
      expose :contribution
      expose :status
    end
  end
end
