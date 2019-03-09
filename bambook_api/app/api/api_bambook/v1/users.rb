module ApiBambook
  module V1
    class Users < Main
      resource :users do
        desc 'Return list of users'
        params do
          optional :page, type: Integer, default: 1
        end
        get do
          users = User.all.page params[:page]
          present :users, paginate(users), with: ApiBambook::Entities::UsersEntity
        end

        desc 'Create a new user.'
        params do
          requires :email, type: String, regexp: User::EMAIL_REGEXP
          requires :password, type: String
        end
        post do
          user = User.new(email: params[:email], password: params[:password])
          if user.save
            present :user, user, with: ApiBambook::Entities::UsersEntity
          else
            error!(user.errors.messages, 422)
          end
        end

        desc 'LogIn.'
        params do
          requires :email, type: String, regexp: User::EMAIL_REGEXP
          requires :password, type: String
        end
        post '/login' do
          command = AuthenticateUser.call(email: params[:email], password: params[:password])
          if command.success?
            present

            {
              access_token: command.access_token,
              message: 'Login Successful'
            }
          else
            error!('Invalid credentials', 401)
          end
        end

        route_param :id do
          desc 'Return a specific user'
          get do
            user = User.find(params[:id])
            present :user, user, with: ApiBambook::Entities::UsersEntity
          end

          desc 'Return list of user books'
          params do
            optional :page, type: Integer, default: 1
          end
          get '/books' do
            user_books = User.find(params[:id]).books.page params[:page]
            present :user_books, paginate(user_books), with: ApiBambook::Entities::BooksEntity
          end

          desc 'Update user'
          params do
            requires :user, type: Hash do
              optional :email, type: String, allow_blank: false
              optional :password, type: String, allow_blank: false
            end
          end
          put do
            user = User.find(params[:id])
            authorize user, :update?
            if user.update(declared_params[:user], include_missing: false)
              present :user, user, with: ApiBambook::Entities::UsersEntity
            else
              error!(user.errors.messages, 422)
            end
          end

          desc 'Delete user'
          delete do
            user = User.find(params[:id])
            authorize user, :destroy?
            user.destroy
            { status: :deleted }
          end
        end
      end
    end
  end
end
