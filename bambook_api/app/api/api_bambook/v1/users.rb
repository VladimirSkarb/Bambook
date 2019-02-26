module ApiBambook
  module V1
    class Users < Main
      resource :users do
        desc 'Return list of users'
        get do
          users = User.all
          present users, with: ApiBambook::Entities::UsersEntity
        end

        desc 'Create a new user.'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post do
          user = User.new(email: params[:email], password: params[:password])
          if user.save
            present user, with: ApiBambook::Entities::UsersEntity
          else
            error!(user.errors.messages, 422)
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
            error!(command.errors, 404)
          end
        end

        route_param :id do
          desc 'Return a specific user'
          get do
            user = User.find(params[:id])
            present user, with: ApiBambook::Entities::UsersEntity
          end

          desc 'Delete user'
          delete do
            user = User.find(params[:id])
            if owner?(user)
              user.destroy
              { status: :deleted }
            else
              { status: :no_access }
            end
          end

          desc 'Return list of user books'
          get '/books' do
            user_books = User.find(params[:id]).books
            present user_books, with: ApiBambook::Entities::BooksEntity
          end
        end
      end
    end
  end
end
