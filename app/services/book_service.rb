class BookService
  include HTTParty

  # Documentation: http://www.penguinrandomhouse.biz/webservices/rest/
  base_uri "https://reststop.randomhouse.com"
  basic_auth "username", "password"

  WORKS_EP = "/resources/works".freeze

  # http://www.penguinrandomhouse.biz/webservices/rest/#works
  WORKS_FIELDS = %w(authorweb onsaledate series titleAuth titleSubtitleAuth
                    titleshort titleweb workid)

  # GET /resources/works
  def works(query)
    self.class.get("#{WORKS_EP}?#{query.to_query}")
  end
end
