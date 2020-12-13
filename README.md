# Books API Search

This project contains an API that exposes an open source books API, provided by [Penguin Random House](http://www.penguinrandomhouse.biz/webservices/rest).

## Requirements

* Ruby 2.5
* PostgreSQL 12.4

## Installation

```
git clone https://github.com/kaydanzie/books-api-search.git
cd books-api-search
bundle install
bundle exec rails db:setup
```

To start the server locally:

```
bundle exec rails s
```

## Usage

These are the endpoints provided by this API:

### /api/v1/books

**Query Parameters**

See the [Penguin Random House API documentation](http://www.penguinrandomhouse.biz/webservices/rest/#works) for more optional fields related to this endpoint.

* `search` (Required): A string containing either a title or author you'd like to search by.
* `fields` (Optional): A string containing comma-separated values that specify the fields you would like to be returned. Must be one of the fields listed in the documentation.

**Example Request and Response**

```
$ curl "localhost:5000/api/v1/books?search=Rowling&fields=titleweb,workid"
{"works":{"work":[{"titleweb":"Harry Potter and the Chamber of Secrets","workid":"158321"},{"titleweb":"Harry Potter and the Deathly Hallows","workid":"158322"},{"titleweb":"Harry Potter \u0026 the Goblet of Fire","workid":"158324"},{"titleweb":"Harry Potter and the Half-Blood Prince","workid":"158325"},{"titleweb":"Harry Potter and the Order of the Phoenix","workid":"158326"},{"titleweb":"Harry Potter \u0026 the Prisoner of Azkaban","workid":"158327"},{"titleweb":"Harry Potter and the Sorcerer's Stone","workid":"158330"},{"titleweb":"Harry Potter 1-7 Audio Collection","workid":"225957"},{"titleweb":"Who Is J.K. Rowling?","workid":"311154"},{"titleweb":"Life in Medieval Times","workid":"336673"}],"uri":"https://reststop.randomhouse.com/resources/works?search=Rowling"}}
```
