class BooksController < ApplicationController
  # GET /api/v1/books
  def index
    if BookSearch.exists?(query_params: request.query_parameters)
      api_response = BookSearch.find_by(query_params: request.query_parameters).api_data
    else
      api_response = BookService.new.works(request.query_parameters)
      # TODO: Add logic to handle errors when creating BookSearch
      BookSearch.create(query_params: request.query_parameters, api_data: api_response)
    end

    render json: api_response, status: :ok
  end
end
