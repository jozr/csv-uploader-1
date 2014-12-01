require 'pg'
require 'sinatra'
require 'sinatra/activerecord'

set :database, 'postgres://localhost/deal_a_day'
DB = PG.connect({:dbname => 'deal_a_day'})

class Detail < ActiveRecord::Base
end

get '/' do
  erb :index
end

post '/' do
  File.open('uploads/' + params['upload'][:filename], "w") do |f|
    f.write(params['upload'][:tempfile].read)
  end

  file_name = File.absolute_path('uploads/' + params['upload'][:filename]) 
  DB.exec("COPY details(purchaser_name, description, price, amount, address, merchant_name) FROM '#{file_name}' WITH CSV HEADER DELIMITER AS ',';")
  
  return "Your file was successfully uploaded!"
end