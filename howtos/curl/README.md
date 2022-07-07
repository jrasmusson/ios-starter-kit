# Curl Commands

```
GET
curl http://localhost:4567/posts
curl http://localhost:4567/posts/0

CREATE
curl -d '{"title":"value1", "body":"value2"}' -H "Content-Type: application/json" -X POST http://localhost:4567/posts

UPDATE
curl -d '{"title":"value11", "body":"value22"}' -H "Content-Type: application/json" -X PUT http://localhost:4567/posts/1

DELETE
curl -H "Content-Type: application/json" -X DELETE http://localhost:4567/posts/1

https://fierce-retreat-36855.herokuapp.com/posts
```
### Links that help

- [CRUD end point Sinatra](https://dev.to/alexmercedcoder/creating-a-full-crud-api-with-ruby-sinatra-15b4)