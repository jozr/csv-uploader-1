require 'sinatra'
require 'sinatra/flash'
require 'sinatra/activerecord'

Dir.glob('./lib/*.rb').each { |f| require f }

set :database, 'postgres://localhost/deal_a_day'
enable :sessions
 
get '/' do
  erb :index
end

post '/' do
  link = "<a href=\"/\">Again?</a>"
  if params['upload']
    Detail.upload(params['upload'])
    flash[:success] = "The total amount of revenue is $#{Detail.latest_upload_revenue}0. Lookin' good!<br />#{link}"    
  else
    flash[:error] = "You did not select a file to upload.<br />#{link}"
  end
end