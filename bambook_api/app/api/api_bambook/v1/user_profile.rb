module ApiBambook
  module V1
    class UserProfile < Main
      resource :profile do
        desc 'User Profile'
        get do
          authenticate!
          authorize current_user, :user_profile?
          present :user, current_user, with: ApiBambook::Entities::UsersEntity
          present :wallet, current_user.wallet, with: ApiBambook::Entities::WalletsEntity
        end

        desc 'Recharge balance'
        params do
          requires :sum, type: Integer
        end
        post '/recharges' do
          authenticate!
          recharge = current_user.wallet.balance_recharges.create(amount: params[:sum], email: current_user.email)
          if recharge.save
            { status: :success }
          else
            error!(recharge.errors.messages, 422)
          end
        end

        desc 'get balance recharges '
        get '/recharges' do
          authenticate!
          authorize current_user, :user_profile?
          recharges = current_user.wallet.balance_recharges.reverse
          present :recharges, recharges, with: ApiBambook::Entities::RechargesEntity
        end

        desc 'get user offers '
        get '/offers' do
          authenticate!
          authorize current_user, :user_profile?
          uploaded_offers = current_user.uploaded_offer_owners.map(&:uploaded_offer)
          present uploaded_offers, with: ApiBambook::Entities::UploadedOffersEntity
        end
      end
    end
  end
end
