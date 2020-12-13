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

  def filtered_response(data, fields)
    return nil if fields.blank?

    # If none of the fields passed by the user are valid, just return all the fields.
    allowed_fields = (fields.split(",") & WORKS_FIELDS).presence || WORKS_FIELDS
    data.dig('works', 'work')&.map! { |a| a.slice(*allowed_fields) }
    data
  end
end
