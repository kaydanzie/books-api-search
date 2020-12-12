class BookSearch < ApplicationRecord
  validates :query_params, uniqueness: true, presence: true
end
