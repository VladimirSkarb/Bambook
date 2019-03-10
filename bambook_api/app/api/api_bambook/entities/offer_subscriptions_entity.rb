module ApiBambook
  module Entities
    class OfferSubscriptionsEntity < Grape::Entity
      expose :id
      expose :offer_id
      expose :user_id
    end
  end
end
