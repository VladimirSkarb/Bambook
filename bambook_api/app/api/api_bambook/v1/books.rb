module ApiBambook
  module V1
    class Books < Main
      resource :books do
        desc 'Return list of books'
        get do
          books = Book.all
          present books, with: ApiBambook::Entities::BooksEntity
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
        end
        post do
          if logged_in?
            book = @current_user.books.new(declared_params[:book])
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

        route_param :book_id do
          desc 'Return a specific book'
          get do
            book = Book.find(params[:book_id])
            present book, with: ApiBambook::Entities::BooksEntity
          end

          desc 'Update a specific book'
          params do
            requires :book, type: Hash do
              optional :title, type: String, allow_blank: false
              optional :description, type: String, allow_blank: false
              optional :author, type: String, allow_blank: false
            end
            optional :cover_photo, type: File, allow_blank: false
            optional :book_file, type: File, allow_blank: false
          end
          put do
            book = current_user.books.find(params[:book_id])
            book if book.update(declared_params[:book])
            book.attachment_manager(params, book)
            present book, with: ApiBambook::Entities::BooksEntity
          end

          desc 'Delete a specific book'
          delete do
            current_user.books.find(params[:book_id]).destroy
            { status: :deleted }
          end

          # Operations with reviews

          desc 'Create review for a specific book'
          params do
            requires :comment, type: String
            requires :rating, type: Integer
          end
          post '/reviews' do
            book = Book.find(params[:id])
            if logged_in?
              review = book.reviews.create(comment: params[:comment], rating: params[:rating], user_id: current_user.id)
              present review, with: ApiBambook::Entities::ReviewsEntity
            else
              { status: :not_registered }
            end
          end

          desc 'Get reviews of specific book'
          get '/reviews' do
            reviews = Book.find(params[:book_id]).reviews
            present reviews, with: ApiBambook::Entities::ReviewsEntity
          end
        end
      end
    end
  end
end
