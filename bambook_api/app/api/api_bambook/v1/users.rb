module ApiBambook
  module V1
    class Users < Main
      resource :users do
        get 'test' do
          { user: 'Hello' }
        end

        desc 'Return list of users'
        get do
          users = User.all
          present users, with: ApiBambook::Entities::UsersEntity
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
          command = AuthenticateUser.call(email: params[:email], password: params[:password])
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

        desc 'Return a specific user'
        route_param :id do
          get do
            user = User.find(params[:id])
            present user, with: ApiBambook::Entities::UsersEntity
          end
        end

        desc 'Delete user'
        params do
          optional :Authorization, type: String, documentation: { param_type: 'header' }
        end
        route_param :id do
          delete do
            user = User.find(params[:id])
            if current_user?(user)
              user.destroy
              { status: :deleted }
            else
              { status: :no_access }
            end
          end
        end
      end
    end
  end
end
