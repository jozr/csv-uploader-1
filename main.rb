require 'sinatra'
require 'sinatra/flash'
require 'sinatra/activerecord'

Dir.glob('./lib/*.rb').each { |f| require f }

set :database, 'postgres://localhost/deal_a_day'
enable :sessions
@@current_user_id = nil
 
get '/' do
  erb :index
end

post '/' do
  link = "<a href=\"/\">Again?</a>"
  if @@current_user_id.nil?
  	flash[:error] = 'You must login to upload a file.'
  else 
  	if params['upload']
      Detail.upload(params['upload'])
      flash[:success] = "The total amount of revenue is $#{Detail.latest_upload_revenue}0. Lookin' good!"    
    else
      flash[:error] = "You did not select a file to upload."
    end
  end
  redirect '/'
end

get '/auth/login' do
  erb :login
end

post '/auth/login' do
  input = params['user']
  user = User.new(email: input['email'], password: input['password'])
  if user.save
    @@current_user_id = user.id
    flash[:success] = 'You have successfully logged in!'
    redirect '/'
  else
  	flash[:error] = 'You left the field(s) blank.'
  	redirect '/auth/login'
  end
end

get '/auth/logout' do
  if @@current_user_id.nil?
    flash[:error] = 'Nobody is logged in!'
  else
  	@@current_user_id = nil
    flash[:success] = 'You have successfully logged out!'
  end
  redirect '/' 
end
