require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "#index" do
    it 'returns a json' do
      # Arrange
      # Returns fake data when we call the API while the test is running
      stub_works_api

      # Act
      get books_path(params: { search: "The Great Gatsby" })

      # Assert
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key("works")
    end

    it 'creates a BookSearch' do
      # Arrange
      stub_works_api

      # Act & Assert
      expect { 
        get books_path(params: { search: "The Great Gatsby" })
      }.to change(BookSearch, :count).by(1)
    end

    it 'is filterable' do
      # Arrange
      stub_works_api

      # Act
      get books_path(params: { search: "The Great Gatsby", fields: "titleweb,titleshort" })

      # Assert
      single_work = JSON.parse(response.body)['works']['work'].first
      expect(single_work).to have_key('titleweb')
      expect(single_work).not_to have_key('workid')
    end

    context 'if BookSearch with query params already exists' do
      let(:params) { { search: "The Great Gatsby" } }

      it "doesn't create a new BookSearch" do
        # Arrange
        BookSearch.create(query_params: params, api_data: works_api_response)

        # Act & Assert
        expect { get books_path(params: params) }.not_to change(BookSearch, :count)
      end

      it "doesn't make a request to the external API" do
        # Arrange
        BookSearch.create(query_params: params, api_data: works_api_response)
        api_request = stub_works_api

        # Act
        get books_path(params: params)

        # Assert
        expect(api_request).not_to have_been_requested
      end
    end

    context 'when the search query param is missing' do
      it 'returns an error json' do
        # Act
        get books_path

        # Assert
        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to have_key("error")
      end
    end

    context 'when the external API returns an error' do
      it 'renders a json with the error' do
        # Arrange
        stub_works_api_not_found

        # Act
        get books_path(params: { search: "The Great Gatsby" })

        # Assert
        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq("application/json")
      end

      it "doesn't create a new BookSearch" do
        # Arrange
        stub_works_api_not_found

        # Act & Assert
        expect {
          get books_path(params: { search: "The Great Gatsby" })
        }.not_to change(BookSearch, :count)
      end
    end
  end
end
