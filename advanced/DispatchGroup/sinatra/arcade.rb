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
      id: "1",
      name: "Pacman",
  }.to_json
end

get '/game/2' do
  {
      id: "2",
      name: "Donkey Kong",
  }.to_json
end

get '/game/3' do
  {
      id: "3",
      name: "Space Invaders",
  }.to_json
end
