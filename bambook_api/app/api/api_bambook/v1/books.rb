module ApiBambook
  module V1
    class Books < Main
      resource :books do
        desc 'Return list of books'
        params do
          optional :page, type: Integer, default: 1
        end
        get do
          books = Book.all.page params[:page]
          present paginate(books), with: ApiBambook::Entities::BooksEntity
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
          authenticate!
          book = @current_user.books.new(declared_params[:book])
          if book.valid?
            attach_files = book.attachment_manager(params, book)
            if book.cover_photo.attached? && book.book_file.attached?
              book.save
              present book, with: ApiBambook::Entities::BooksEntity
            else
              error!(attach_files, 422)
            end
          else
            error!(book.errors.messages, 422)
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
            authenticate!
            book = current_user.books.find(params[:book_id])
            book if book.update(declared_params[:book], include_missing: false)
            book.attachment_manager(params, book)
            present book, with: ApiBambook::Entities::BooksEntity
          end

          desc 'Delete a specific book'
          delete do
            authenticate!
            current_user.books.find(params[:book_id]).destroy
            { status: :deleted }
          end

          # Operations with reviews

          desc 'Create review for a specific book'
          params do
            requires :comment, type: String
            requires :rating, type: Integer, values: 1..5, desc: 'Value between 1..5'
          end
          post '/reviews' do
            authenticate!
            book = Book.find(params[:book_id])
            review = book.reviews.create(comment: params[:comment], rating: params[:rating], user_id: current_user.id)
            present review, with: ApiBambook::Entities::ReviewsEntity
          end

          desc 'Get reviews of specific book'
          params do
            optional :page, type: Integer, default: 1
          end
          get '/reviews' do
            reviews = Book.find(params[:book_id]).reviews.page params[:page]
            present paginate(reviews), with: ApiBambook::Entities::ReviewsEntity
          end

          route_param :review_id do
            desc 'Delete a specific review'
            delete '/reviews' do
              authenticate!
              current_user.reviews.find(params[:review_id]).destroy
              { status: :deleted }
            end

            params do
              optional :comment, type: String
              optional :rating, type: Integer
            end
            put '/reviews' do
              authenticate!
              review = current_user.reviews.find(params[:review_id])
              review if review.update(comment: params[:comment], rating: params[:rating])
              present review, with: ApiBambook::Entities::ReviewsEntity
            end
          end
        end
      end
    end
  end
end
