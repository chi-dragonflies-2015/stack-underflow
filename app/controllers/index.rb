get '/' do
  @questions = Question.all #.limit(10)
  erb :index
end

get '/login' do
  erb :"login"
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

post '/question_form' do
  new_question = Question.new(params[:question])
  new_question.user = User.find(session[:user_id])
  if new_question.save
    redirect '/'
  else
    redirect '/question_form'
  end
end
