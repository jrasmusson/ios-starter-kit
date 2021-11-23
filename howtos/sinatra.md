# How to Sinatra

## How to create sinatra app push to heroku

```
mkdir sinatra
cd sinatra
gem install sinatra
```

**arcade.rb**

```ruby
require 'sinatra'
require 'json'

before do
  content_type :json
end

get '/hi' do
  "Hello World"
end

get '/game/1' do
  {
      game: "Wake me Up",
      year: "1984"
  }.to_json
end

get '/game/2' do
    send_file 'test.json'
end
```

**config.ru**

```ruby
require './arcade'
run Sinatra::Application
```

**Gemfile**

```ruby
source 'https://rubygems.org'
gem 'sinatra'
```

`ruby arcade.rb` // http://localhost:4567

### Setup repos and push

```
bundle install
git init
git add .
git commit -m "init"

heroku login
heroku create
git push heroku master
heroku ps:scale web=1

heroku open
```

`https://fierce-retreat-36855.herokuapp.com/`

## How to add a new end point

Goto sinatra repo dir.

Make changes

- Update rb files
- Add to config.ru

To push

```
> heroku login
> git push heroku main
> https://git.heroku.com/fierce-retreat-36855
```
### Links that help

- http://sinatrarb.com/intro.html
- https://devcenter.heroku.com/articles/rack
- https://devcenter.heroku.com/articles/getting-started-with-rails6
- https://devblast.com/b/return-json-in-sinatra
- [Tutorial](https://www.devdungeon.com/content/ruby-sinatra-tutorial#toc-24)
