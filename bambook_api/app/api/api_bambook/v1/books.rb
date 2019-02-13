module ApiBambook
  module V1
    class Books < Main
      resource :books do

        before do
          puts '**************'
          puts @current_user.email
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
        end
        post do
          book = Book.new(declared(params, include_missing: false)[:book])
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
            #binding.pry
            book = Book.find(params[:id])
            book if book.update(declared(params, include_missing: false)[:book])
            present book, with: ApiBambook::Entities::BooksEntity
          end
        end

        desc 'Delete a specific book'
        route_param :id do
          delete do
            book = Book.find(params[:id])
            book.destroy
            {status: :deleted}
          end
        end
      end
    end
  end
end