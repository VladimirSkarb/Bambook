require 'pry'
module ApiBambook
  module V1
    class Books < Grape::API
      resource :books do
        #binding.pry
        desc 'Return list of books'
        get do
          books = Book.all
          present books, with: ApiBambook::Entities::Book
        end

        desc 'Return a specific book'
        route_param :id do
          get do
            book = Book.find(params[:id])
            present book, with: ApiBambook::Entities::Book
          end
        end

        desc 'Create a new book'
        params do
          requires :title, type: String
          requires :description, type: String
          requires :author, type: String
          requires :cover_photo, type: File
          requires :book_file, type: File
        end
        post do
          book = Book.new({ title:params[:title], description:params[:description], author:params[:author]})
          #binding.pry
          if book.save
            book.cover_photo.attach(io:File.open(params[:cover_photo][:tempfile].path), filename: params[:cover_photo][:filename])
            book.book_file.attach(io:File.open(params[:book_file][:tempfile].path), filename: params[:book_file][:filename])
            if book.cover_photo.attached? && book.book_file.attached?
              present book, with: ApiBambook::Entities::Book
            else
              { error: 'The book was not attached. Please, try again!' }
            end
          else
            { error: "#{book.errors.full_messages}" }
          end
        end

        desc 'Update a specific book'
        params do
          requires :title, type: String
          requires :description, type: String
          requires :author, type: String
        end
        route_param :id do
          put do
            book = Book.find(params[:id]).update({ title:params[:title], description:params[:description],author:params[:author] })
            #present book, with: ApiBambook::Entities::Book
          end
        end

        desc 'Delete a specific book'
        route_param :id do
          delete do
            book = Book.find(params[:id])
            book.destroy
          end
        end
      end
    end
  end
end