module ApiBambook
  module V1
    class Books < Main
      resource :books do
        desc 'Return list of books'
        params do
          optional :page, type: Integer, default: 1
        end
        get do
          books = Book.order('created_at DESC')
          books_count = Book.count
          current_page = params[:page]
          present :books, paginate(books), with: ApiBambook::Entities::BooksEntity
          present :books_count, books_count
          present :current_page, current_page
        end

        desc 'Create a new book'
        params do
          requires :book, type: Hash do
            requires :title, type: String
            requires :description, type: String
            requires :author, type: String
            requires :cover_photo, type: File
            requires :book_file, type: File
          end
        end
        post do
          authenticate!
          book = @current_user.books.new(declared_params[:book])
          if book.save
            present :book, book, with: ApiBambook::Entities::BooksEntity
          else
            error!(book.errors.messages, 422)
          end
        end

        route_param :book_id do
          desc 'Return a specific book'
          get do
            book = Book.find(params[:book_id])
            rating = book.reviews.average(:rating)&.round
            present :book, book, with: ApiBambook::Entities::BooksEntity
            present :rating, rating, with: ApiBambook::Entities::BooksRatingEntity, rating: rating
          end

          desc 'Update a specific book'
          params do
            requires :book, type: Hash do
              optional :title, type: String
              optional :description, type: String
              optional :author, type: String
              optional :cover_photo, type: File
              optional :book_file, type: File
            end
          end
          put do
            authenticate!
            book = current_user.books.find(params[:book_id])
            book if book.update(declared_params[:book])
            present :book, book, with: ApiBambook::Entities::BooksEntity
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
            review = book.reviews.new(comment: params[:comment], rating: params[:rating], user_id: current_user.id)
            if review.save
              present :review, review, with: ApiBambook::Entities::ReviewsEntity
            else
              error!(review.errors.messages, 422)
            end
          end

          desc 'Get reviews of specific book'
          # params do
          #   optional :page, type: Integer, default: 1
          # end
          get '/reviews' do
            reviews = Book.find(params[:book_id]).reviews.order('created_at DESC')#.page params[:page]
            # present :reviews, paginate(reviews), with: ApiBambook::Entities::ReviewsEntity
            present :reviews, reviews, with: ApiBambook::Entities::ReviewsEntity
          end

          route_param :review_id do
            desc 'Delete a specific review'
            delete '/reviews' do
              authenticate!
              current_user.reviews.find(params[:review_id]).destroy
              { status: :deleted }
            end

            params do
              requires :review, type: Hash do
                optional :comment, type: String, allow_blank: false
                optional :rating, type: Integer, values: 1..5, desc: 'Value between 1..5', allow_blank: false
              end
            end
            put '/reviews' do
              authenticate!
              review = current_user.reviews.find(params[:review_id])
              review if review.update(declared_params[:review])
              present :review, review, with: ApiBambook::Entities::ReviewsEntity
            end
          end
        end
      end
    end
  end
end
