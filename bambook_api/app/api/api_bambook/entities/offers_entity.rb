module ApiBambook
  module Entities
    class OffersEntity < Grape::Entity
      expose :id
      expose :deadline
      expose :link
      expose :minimum_quantity
      expose :user_id
      expose :status
    end
  end
end
