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
  end
end
