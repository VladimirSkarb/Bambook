module ApiBambook
  module Entities
    class RechargesEntity < Grape::Entity
      expose :id
      expose :amount
      expose :status
    end
  end
end
