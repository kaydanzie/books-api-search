def works_api_response
  {
    works: [
      {
        workid: 1,
        titleweb: "The Great Gatsby",
        titleshort: "GREAT GATSBY, THE",
        authorweb: "FITZGERALD, F. SCOTT"
      }
    ]
  }.to_json
end

def stub_works_api
  base_uri = Regexp.new "#{BookService.base_uri}#{BookService::WORKS_EP}"
  stub_request(:get, base_uri).to_return(status: 200, body: works_api_response)
end

def stub_works_api_not_found
  base_uri = Regexp.new "#{BookService.base_uri}#{BookService::WORKS_EP}"
  stub_request(:get, base_uri).to_return(
    status: 404, body: { error: "404 Not Found" }.to_json
  )
end
