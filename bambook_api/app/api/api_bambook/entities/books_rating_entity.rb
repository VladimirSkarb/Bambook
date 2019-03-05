module ApiBambook
  module Entities
    class BooksRatingEntity < Grape::Entity
      expose :rating do |item, options|
        options[:rating]
      end
    end
  end
end
