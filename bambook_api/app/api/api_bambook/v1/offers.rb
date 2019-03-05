module ApiBambook
  module V1
    class Offers < Main
      resource :offers do
        get do
          books = Offer.all
          present books, with: ApiBambook::Entities::OffersEntity
        end

        route_param :offer_id do
          desc 'Return a specific offer'
          get do
            offer = Offer.find(params[:offer_id])
            present offer, with: ApiBambook::Entities::OffersEntity
          end
        end
      end
    end
  end
end
