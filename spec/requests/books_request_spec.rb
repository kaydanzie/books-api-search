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

    context 'if BookSearch with query params already exists' do
      let(:params) { { search: "The Great Gatsby" } }

      it "doesn't create a new BookSearch" do
        # Arrange
        BookSearch.create(query_params: params)

        # Act & Assert
        expect { get books_path(params: params) }.not_to change(BookSearch, :count)
      end

      it "doesn't make a request to the external API" do
        # Arrange
        BookSearch.create(query_params: params)
        api_request = stub_works_api

        # Act
        get books_path(params: params)

        # Assert
        expect(api_request).not_to have_been_requested
      end
    end
  end
end
