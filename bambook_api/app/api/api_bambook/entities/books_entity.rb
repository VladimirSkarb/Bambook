module ApiBambook
  module Entities
    class BooksEntity < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.strftime('%Y-%m-%d %H:%M') }

      expose :id
      expose :title
      expose :author
      expose :description
      expose :product_image_url
      expose :download_book_url
      expose :user_id

      with_options(format_with: :iso_timestamp) do
        expose :created_at
        expose :updated_at
      end
    end
  end
end
