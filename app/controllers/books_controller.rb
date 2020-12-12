class BooksController < ApplicationController
  before_action :set_book_search

  # GET /api/v1/books
  def index
    if request.query_parameters['search'].blank?
      render_missing_param("search")
    elsif @book_search.present?
      render json: @book_search.api_data, status: :ok
    else
      api_response = BookService.new.works(request.query_parameters)
      # TODO: Add logic to handle errors when creating BookSearch
      BookSearch.create(query_params: request.query_parameters, api_data: api_response)
      render json: api_response, status: :ok
    end
  end

  private

  def render_missing_param(required_param)
    render json: { error: "'#{required_param}' query parameter is required" },
           status: :bad_request
  end

  def set_book_search
    @book_search = BookSearch.find_by(query_params: request.query_parameters)
  end
end
