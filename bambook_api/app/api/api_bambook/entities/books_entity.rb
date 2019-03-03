module ApiBambook
  module Entities
    class BooksEntity < Grape::Entity
      expose :id
      expose :title
      expose :author
      expose :description
      expose :product_image_url
      expose :download_book_url
      expose :user_id
    end
  end
end
