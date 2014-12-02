require 'pg'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/activerecord'

set :database, 'postgres://localhost/deal_a_day'
DB = PG.connect({:dbname => 'deal_a_day'})
enable :sessions

class Detail < ActiveRecord::Base
  def self.upload(file)
    File.open('uploads/' + file[:filename], "w") do |f|
      f.write(file[:tempfile].read)
    end
    file_name = File.absolute_path('uploads/' + file[:filename]) 
    DB.exec("COPY details(purchaser_name, description, price, amount, address, merchant_name) FROM '#{file_name}' WITH CSV HEADER DELIMITER AS ',';")
    DB.exec("UPDATE details SET created_at = NOW() WHERE created_at IS NULL;")
  end
  
  def self.latest_upload_revenue
    total = 0
    latest_upload = Detail.order('created_at').last
    Detail.all.each do |d|
      if d.created_at == latest_upload.created_at
        total += d.price * d.amount
      end
    end
    total
  end
end
 
get '/' do
  erb :index
end

post '/' do
  if params['upload']
    Detail.upload(params['upload'])
    flash[:success] = "The total amount of revenue is $#{Detail.latest_upload_revenue}0. Lookin' good!"
  else
    flash[:error] = "You did not select a file to upload."
  end
end