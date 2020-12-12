class CreateBookSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :book_searches do |t|
      t.jsonb :query_params, unique: true, null: false
      t.jsonb :api_data

      t.timestamps
    end
  end
end
