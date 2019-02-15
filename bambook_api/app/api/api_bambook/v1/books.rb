module ApiBambook
  module V1
    class Books < Main
      resource :books do
        before do
          puts '**************'
          puts @current_user.email if @current_user
          puts logged_in?
          puts '**************'
        end

        desc 'Return list of books'
        get do
          books = Book.all
          present books, with: ApiBambook::Entities::BooksEntity
        end

        desc 'Return a specific book'
        route_param :id do
          get do
            book = Book.find(params[:id])
            present book, with: ApiBambook::Entities::BooksEntity
          end
        end

        desc 'Create a new book'
        params do
          requires :book, type: Hash do
            requires :title, type: String
            requires :description, type: String
            requires :author, type: String
          end
          requires :cover_photo, type: File
          requires :book_file, type: File
          # field for Authorization Token
          optional :Authorization, type: String, documentation: { param_type: 'header' }
        end
        post do
          if logged_in?
            book = @current_user.books.new(declared(params, include_missing: false)[:book])
            if book.valid?
              attach_files = book.attachment_manager(params, book)
              if book.cover_photo.attached? && book.book_file.attached?
                book.save
                present book, with: ApiBambook::Entities::BooksEntity
              else
                attach_files
              end
            else
              { error: book.errors.messages }
            end
          else
            { status: :not_registered }
          end
        end

        desc 'Update a specific book'
        params do
          requires :book, type: Hash do
            optional :title, type: String, allow_blank: false
            optional :description, type: String, allow_blank: false
            optional :author, type: String, allow_blank: false
            optional :cover_photo, type: File, allow_blank: false
            optional :book_file, type: File, allow_blank: false
          end
        end
        route_param :id do
          put do
            book = Book.find(params[:id])
            if current_user?(book.user)
              book if book.update(declared(params, include_missing: false)[:book])
              present book, with: ApiBambook::Entities::BooksEntity
            else
              { status: :no_access }
            end
          end
        end

        desc 'Delete a specific book'
        route_param :id do
          delete do
            book = Book.find(params[:id])
            if current_user?(book.user)
              book.destroy
              { status: :deleted }
            else
              { status: :no_access }
            end
          end
        end

        desc 'Get reviews of specific book'
        route_param :id do
          get '/reviews' do
            book = Book.find(params[:id])
            reviews = book.reviews
            present reviews, with: ApiBambook::Entities::ReviewsEntity
          end
        end

        desc 'Create review for a specific book'
        params do
          requires :comment, type: String
          requires :rating, type: Integer
          optional :Authorization, type: String, documentation: { param_type: 'header' }
        end
        route_param :id do
          post '/reviews' do
            book = Book.find(params[:id])
            if logged_in?
              review = book.reviews.create(comment: params[:comment], rating: params[:rating], user_id: @current_user.id)
              present review, with: ApiBambook::Entities::ReviewsEntity
            else
              { status: :not_registered }
            end
          end
        end
      end
    end
  end
end
