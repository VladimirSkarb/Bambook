class BooksController < ApplicationController

  # GET /books
  def index
    @books = Book.all

    render json: @books
  end

end
