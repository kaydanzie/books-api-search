require 'rails_helper'

RSpec.describe BookService do
  describe "#works" do
    it 'returns an HTTParty Response' do
      # Arrange
      stub_works_api

      # Assert
      expect(BookService.new.works(search: "Kite Runner")).to be_a(HTTParty::Response)
    end
  end

  describe "#filtered_response" do
    it 'returns filtered data' do
      # Arrange
      unfiltered_data = works_api_response
      fields_to_return = unfiltered_data[:works][:work].first.keys[0..1]

      # Act
      filtered_data = BookService.new.filtered_response(
        unfiltered_data.deep_stringify_keys, fields_to_return.join(",")
      )

      # Assert
      expected_keys = fields_to_return.map(&:to_s)
      expect(filtered_data['works']['work'].first.keys).to contain_exactly(*expected_keys)
    end

    it 'returns all data if no valid fields are specified' do
      # Arrange
      unfiltered_data = works_api_response

      # Act
      filtered_data = BookService.new.filtered_response(
        unfiltered_data.deep_stringify_keys, "invalidfield"
      )

      # Assert
      expected_keys = unfiltered_data[:works][:work].first.keys.map(&:to_s)
      expect(filtered_data['works']['work'].first.keys).to contain_exactly(*expected_keys)
    end
  end
end
