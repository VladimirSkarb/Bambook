module ApiBambook
  module Entities
    class Book < Grape::Entity
      expose :id
      expose :title
      expose :author
      expose :description
    end
  end
end