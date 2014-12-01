require 'pg'
require 'sinatra'
require 'sinatra/activerecord'
require 'json'

set :database, 'postgres://localhost/deal_a_day'

class Detail < ActiveRecord::Base
end

get '/' do
  erb :index
end

post '/' do
  File.open('uploads/' + params['upload'][:filename], "w") do |f|
    f.write(params['upload'][:tempfile].read)
  end
  return "Your data was successfully uploaded!"
end