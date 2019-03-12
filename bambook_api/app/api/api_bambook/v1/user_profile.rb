module ApiBambook
  module V1
    class UserProfile < Main
      resource :profile do
        desc 'User Profile'
        get do
          authenticate!
          authorize user, :user_profile?
          present :user, user, with: ApiBambook::Entities::UsersEntity
          present :wallet, user.wallet, with: ApiBambook::Entities::WalletsEntity
        end

        desc 'Recharge balance'
        params do
          requires :sum, type: Integer
        end
        post '/recharges' do
          authenticate!
          recharge = current_user.wallet.balance_recharges.create(amount: params[:sum])
          if recharge.save
            { status: :success }
          else
            error!(recharge.errors.messages, 422)
          end
        end

        desc 'get balance recharges '
        get '/recharges' do
          authenticate!
          recharges = current_user.wallet.balance_recharges
          present :recharges, recharges, with: ApiBambook::Entities::RechargesEntity
        end
      end
    end
  end
end
