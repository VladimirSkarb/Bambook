module ApiBambook
  module Entities
    class WalletsEntity < Grape::Entity
      expose :id
      expose :available_money
      expose :frozen_money
    end
  end
end
