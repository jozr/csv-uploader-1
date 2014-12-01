require 'sinatra'
require 'sinatra/activerecord'
require 'json'

set :database, 'postgres://localhost/deal_a_day'

get '/' do
  erb :index
end