get '/login' do
  erb :"login"
end

get '/' do
  @questions = Question.limit(10)
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.authenticate(params[:login][:user_name], params[:login][:password])
  if @user
    session[:user_id] = @user.id
    redirect '/'
  else
    @incorrect_login = true
    erb :login
  end
end

get '/question_form' do
  erb :"question_form"
end
