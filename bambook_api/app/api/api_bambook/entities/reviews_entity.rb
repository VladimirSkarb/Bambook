module ApiBambook
  module Entities
    class ReviewsEntity < Grape::Entity
      expose :id
      expose :comment
      expose :rating
      expose :user_id
      expose :book_id
    end
  end
end
