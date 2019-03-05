module ApiBambook
  module Entities
    class BooksEntity < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.strftime('%Y-%m-%d %H:%M') }

      expose :id
      expose :title
      expose :author
      expose :description
      expose :user_id
      expose :cover_photo
      expose :book_file

      with_options(format_with: :iso_timestamp) do
        expose :created_at
        expose :updated_at
      end
    end
  end
end
