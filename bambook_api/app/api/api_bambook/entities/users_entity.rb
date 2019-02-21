module ApiBambook
  module Entities
    class UsersEntity < Grape::Entity
      expose :id
      expose :email
    end
  end
end
