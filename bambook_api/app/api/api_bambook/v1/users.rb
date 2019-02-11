require 'pry'
module ApiBambook
  module V1
    class Users < Grape::API

      resource :users do
        #binding.pry
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
            present user, with: ApiBambook::Entities::User
          else
            { error: "#{user.errors.full_messages}" }
          end
        end

        desc 'LogIn.'
        params do
          requires :user, type: Hash do
            requires :email, type: String
            requires :password, type: String
          end
        end
        post '/login' do
          #binding.pry
          command = AuthenticateUser.call(declared(params, include_missing: false)[:user])
          if command.success?
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
            'User was destroy'
          end
        end
      end
    end
  end
end
