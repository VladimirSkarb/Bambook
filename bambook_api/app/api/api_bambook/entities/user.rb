module ApiBambook
  module Entities
    class User < Grape::Entity
      expose :id
      expose :email
      expose :password_digest
    end
  end
end