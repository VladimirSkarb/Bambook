module ApiBambook
  module V1
    class Users < Main
      resource :users do
        get 'test' do
          { user: 'Hello'}
        end

        desc 'Create a new user.'
        params do
          requires :user, type: Hash do
            requires :email, type: String
            requires :password, type: String
            requires :password_confirmation, type: String
          end
        end
        post '/register' do
          user = User.new(declared(params, include_missing: false)[:user])
          if user.save
            present user, with: ApiBambook::Entities::UsersEntity
          else
            { error: user.errors.messages }
          end
        end

        desc 'LogIn.'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post '/login' do
          command = AuthenticateUser.call(email:params[:email], password:params[:password])
          if command.success?
            present

            {
                access_token: command.result,
                message: 'Login Successful'
            }
          else
            error!('message', 404)
          end
        end

        desc 'Delete user'
        route_param :id do
          delete do
            user = User.find(params[:id])
            user.destroy
            {status: :deleted}
          end
        end
      end
    end
  end
end
