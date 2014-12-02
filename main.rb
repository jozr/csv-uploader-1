require 'pg'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/activerecord'

set :database, 'postgres://localhost/deal_a_day'
DB = PG.connect({:dbname => 'deal_a_day'})
enable :sessions

class Detail < ActiveRecord::Base
  def self.total_revenue
    total = 0
    Detail.all.each do |d|
      total += d.price * d.amount
    end
    total
  end
end
 
get '/' do
  erb :index
end

post '/' do
  if params[:upload]
    File.open('uploads/' + params['upload'][:filename], "w") do |f|
      f.write(params['upload'][:tempfile].read)
    end
    file_name = File.absolute_path('uploads/' + params['upload'][:filename]) 
    upload = DB.exec("COPY details(purchaser_name, description, price, amount, address, merchant_name) FROM '#{file_name}' WITH CSV HEADER DELIMITER AS ',';")
    flash[:success] = "The total amount of revenue is $#{Detail.total_revenue}0. Lookin' good!"
  else
    flash[:error] = "You did not select a file to upload."
  end
end