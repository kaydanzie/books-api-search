class BookService
  include HTTParty

  # Documentation: http://www.penguinrandomhouse.biz/webservices/rest/
  base_uri "https://reststop.randomhouse.com"
  basic_auth "username", "password"

  WORKS_EP = "/resources/works".freeze

  # GET /resources/works
  def works(query = nil)
    response = self.class.get("#{WORKS_EP}?#{query&.to_query}")
    response.parsed_response
  end
end
