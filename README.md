# BooksApi

To run the project it is necessary to have docker installed

To build the image: 
  * docker-compose build

Before start the server should run: 

  * docker-compose run web mix ecto.setup

To run the tests: 
  * docker-compose run test

To run the web server: 
  * docker-compose up web

Now you can visit [`localhost:4000/api`](http://localhost:4000/api) from your browser or postman

***API Routes***

**Sessions**

> /api/auth

> post

body: 

```Json
{
  "email": "admin@email.com",
  "password": "admin"
}
```

response: 
```Json
{
    "email": "admin@email.com",
    "id": 1,
    "user_name": "admin"
}
```

error response:
```Json
{
    "errors": {
        "detail": "Invalid auth"
    }
}
```
**Authors**
> /api/authors
> post
body

```Json
{ "authors": {
  "first_name": "Some",
  "last_name": "Author"
} }
```

response:

```Json
{
    "data": {
        "books": [],
        "first_name": "josue",
        "id": 9,
        "last_name": "david"
    }
}
```

> /api/authors
> get

```Json
{
    "data": [
        {
            "books": [
                {
                    "description": "some",
                    "id": 4,
                    "title": "book",
                    "year": 2010
                }
            ],
            "first_name": "Guillermo",
            "id": 8,
            "last_name": "Martinez"
        }
    ]
}
```
> /api/authors/1
> delete
```
{
    "ok": {
        "detail": "author deleted"
    }
}
```

**Books**
> /api/books

> post

body

```Json
{ "books": {
  "title": "la vida e bella",
  "description": "some description",
  "year": 2010,
  "author_id": 1
} }
```

response: 
```Json
{
    "data": [
        {
            "author": {
                "first_name": "Joanne",
                "id": 1,
                "last_name": "Rowling1"
            },
            "description": "asd",
            "id": 1,
            "title": "la vida e bella",
            "year": 2010
        },
        {
            "author": {
                "first_name": "Joanne",
                "id": 1,
                "last_name": "Rowling1"
            },
            "description": "some",
            "id": 2,
            "title": "la vida e bella",
            "year": 2010
        },
        {
            "author": {
                "first_name": "Joanne",
                "id": 1,
                "last_name": "Rowling1"
            },
            "description": "some",
            "id": 3,
            "title": "book",
            "year": 2010
        },
        {
            "author": {
                "first_name": "Guillermo",
                "id": 8,
                "last_name": "Martinez"
            },
            "description": "some",
            "id": 4,
            "title": "book",
            "year": 2010
        },
        {
            "author": {
                "first_name": "Angela",
                "id": 7,
                "last_name": "Becerra"
            },
            "description": "some",
            "id": 5,
            "title": "book",
            "year": 2010
        }
    ]
}
```

error response:
```json
{
    "errors": {
        "detail": "You must logged in"
    }
}
```

> /api/books/1
> delete
```
{
    "ok": {
        "detail": "book deleted"
    }
}
```
