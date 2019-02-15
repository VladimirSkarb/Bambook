module ApiBambook
  module Entities
    class UsersEntity < Grape::Entity
      expose :id
      expose :email
      expose :password_digest
    end
  end
end
