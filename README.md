# BooksApi

To run the project it is necessary to have docker installed

To build the image: 
  * docker-compose build

To run the tests: 
  * docker-compose run test

Before start the server should run: 

  * docker-compose run web mix ecto.setup

To run the web server: 
  * docker-compose up web

Now you can visit [`localhost:4000/api`](http://localhost:4000) from your browser or postman

