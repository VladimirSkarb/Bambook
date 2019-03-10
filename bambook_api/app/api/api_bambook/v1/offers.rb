module ApiBambook
  module V1
    class Offers < Main
      resource :offers do
        get do
          offers = Offer.all
          present offers, with: ApiBambook::Entities::OffersEntity
        end

        desc 'Create a new offer'
        params do
          requires :offer, type: Hash do
            requires :deadline, type: Date
            requires :link, type: String
            requires :minimum_quantity, type: Integer
          end
        end
        post do
          authenticate!
          result = PlaceOffer.call(params: declared_params[:offer], user: current_user)

          if result.success?
            present :offer, result.offer, with: ApiBambook::Entities::OffersEntity
            present :offer_subscriptions, result.subscriptions, with: ApiBambook::Entities::OfferSubscriptionsEntity
          else
            error!(result.errors, 422)
          end
        end

        route_param :offer_id do
          desc 'Return a specific offer'
          get do
            offer = Offer.find(params[:offer_id])
            present offer, with: ApiBambook::Entities::OffersEntity
          end

          desc 'Delete offer'
          delete do
            authenticate!
            @current_user.offers.find(params[:offer_id]).destroy
            { status: :deleted }
          end
        end
      end
    end
  end
end
