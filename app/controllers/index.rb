get '/' do
  @user = User.find(session[:user_id])
  @questions = Question.all #.limit(10)
  erb :index
end

get '/login' do
  erb :"login"
end


get '/login' do #>>>>
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

get '/questions/new' do
  erb :"question_form"
end

post '/questions' do
  new_question = Question.new(params[:question])
  new_question.user = User.find(session[:user_id])
  if new_question.save
    redirect '/'
  else
    redirect '/question_form'
  end
end

get '/questions/:id' do
