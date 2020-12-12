class BooksController < ApplicationController
  # GET /api/v1/books
  def index
    api_response = BookService.new.works(request.query_parameters)
    render json: api_response
  end
end
