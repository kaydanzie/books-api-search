class BookService
  include HTTParty

  # Documentation: http://www.penguinrandomhouse.biz/webservices/rest/
  base_uri "https://reststop.randomhouse.com"
  basic_auth "username", "password"

  BOOKS_EP = "/resources/books".freeze

  # GET /resources/books
  def books(query = nil)
    response = self.class.get("#{BOOKS_EP}?#{query}")
    response.parsed_response
  end
end
