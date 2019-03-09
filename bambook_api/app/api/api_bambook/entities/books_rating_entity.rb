module ApiBambook
  module Entities
    class BooksRatingEntity < Grape::Entity
      expose :rating do |_item, options|
        options[:rating]
      end
    end
  end
end
