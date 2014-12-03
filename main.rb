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

get '/auth/login' do
  erb :login
end

post '/auth/login' do
  input = params['user']
  user = User.create(email: input['email'], password: input['password'])
  @@current_user_id = user.id
  flash[:success] = 'You have successfully logged in!'
  redirect('/')
end

get '/auth/logout' do
  if @@current_user_id.nil?
    flash[:success] = 'Nobody is logged in!'
  else
  	@@current_user_id = nil
    flash[:success] = 'You have successfully logged out!'
  end
  redirect '/' 
end
