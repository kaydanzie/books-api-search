class BooksController < ApplicationController
  before_action :set_book_search
  before_action only: :index do
    validate_required_params("search")
  end

  # GET /api/v1/books
  def index
    if @book_search.present?
      render json: @book_search.api_data, status: :ok
    else
      api_response = BookService.new.works(request.query_parameters)

      # We don't want to save/create a BookSearch if the API returned an error
      if api_response.ok?
        # TODO: Add logic to handle errors when creating BookSearch
        BookSearch.create(query_params: request.query_parameters, api_data: api_response.parsed_response)
      end

      render json: api_response.parsed_response, status: api_response.code
    end
  end

  private

  def set_book_search
    @book_search = BookSearch.find_by(query_params: request.query_parameters)
  end
end
