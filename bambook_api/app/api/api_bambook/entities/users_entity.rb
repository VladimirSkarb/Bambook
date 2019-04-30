module ApiBambook
  module Entities
    class UsersEntity < Grape::Entity
      expose :id
      expose :email
      expose :gender
    end
  end
end
