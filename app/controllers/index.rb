get '/' do
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  @user = current_user.authenticate(current_user[:user_name], current_user[:password])
  if @user
    session[:user_id] = @user.id
    redirect '/'
  else
    @incorrect_login = true
    erb :login
  end
end








