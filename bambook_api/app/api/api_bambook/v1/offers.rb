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
          offer = @current_user.offers.new(declared_params[:offer])
          if offer.save
            present :offer, offer, with: ApiBambook::Entities::OffersEntity
          else
            error!(offer.errors.messages, 422)
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

          desc 'Update offer'
          params do
            requires :offer, type: Hash do
              optional :deadline, type: Date
              optional :link, type: String
              optional :minimum_quantity, type: Integer
            end
          end
          put do
            authenticate!
            offer = @current_user.offers.find(params[:offer_id])
            offer if offer.update(declared_params[:offer])
            present :offer, offer, with: ApiBambook::Entities::OffersEntity
          end
          # Operations with offer_subscriptions

          desc 'Create offer_subscription for a specific offer'
          params do
            requires :offer_id, type: String
            requires :user_id,  type: String
          end
          post '/subscriptions' do
            authenticate!
            offer = Offer.find(params[:offer_id])
            offer_subscription = offer.offer_subscriptions.build(user: current_user)
            if offer_subscription.save
              present :offer_subscription, offer_subscription, with: ApiBambook::Entities::OfferSubscriptionsEntity
            else
              error!(offer_subscription.errors.messages, 422)
            end
          end

          desc 'Get offer_subscriptions of specific offer'
          get '/subscriptions' do
            offer_subscriptions = Offer.find(params[:offer_id]).offer_subscriptions
            present :offer_subscriptions, offer_subscriptions, with: ApiBambook::Entities::OfferSubscriptionsEntity
          end

          route_param :offer_subscription_id do
            desc 'Delete a specific offer_subscription'
            delete '/subscription' do
              authenticate!
              offer.offer_subscriptions.find(params[:offer_subscription_id]).destroy
              { status: :deleted }
            end
          end
        end
      end
    end
  end
end
