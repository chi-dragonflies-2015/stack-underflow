get '/' do
  @user = User.find(session[:user_id])
  @questions = Question.all #.limit(10)
  @user = User.find_by(session[:user_id])
  erb :index
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

get '/questions/:id/answers' do
  @question = Question.find(params[:id])
  erb :'/questions/index'

end

get '/questions/:id/edit' do #secure
  redirect "/questions/#{params[:id]}" if !session[:user_id] 
  @question = Question.find(params[:id])
  erb :question_edit

end

put '/questions/:id' do #secure
  redirect "/questions/#{params[:id]}" if !session[:user_id] 
  question = Question.find(params[:id])
  question.update(params[:question])
  redirect "/questions/#{params[:id]}"

end

get '/questions/new' do #secure
  redirect '/' if !session[:user_id]
  erb :question_form
end

post '/questions' do #secure
  redirect '/' if !session[:user_id]
  new_question = Question.new(params[:question])
  new_question.user = User.find(session[:user_id])
  if new_question.save
    redirect '/'
  else
    erb :question_form
  end
end

get '/questions/:id/answers/new' do
  redirect '/questions/:id/answers' if !session[:user_id]
  @question = Question.find(params[:id])
  erb :answer_form
end

post '/questions/:id/answers' do
  answer = Answer.new(params[:answer])
  if answer.save
    redirect '/questions/:id/answers'
  else
    @not_saved = true
    erb :answer_form
  end
end

get '/questions/:question_id/answers/:answer_id/comments/new' do
  @question = Question.find(params[:id])
  @answer = Answer.find(params[:id])
  erb :answer_comment_form
end

post '/questions/:question_id/answers/:answer_id/comments' do
  comment = Comment.new(params[:comment])
  if comment.save
    redirect "/questions/#{params[:question_id]}/answers"
  else
    @not_saved = true
    erb :answer_comment_form
  end
end

get '/questions/:id/comments/new' do
  @question = Question.find(params[:id])
  erb :question_comment_form
end

post '/questions/:id/comments' do
  comment = Comment.new(params[:comment])
  if comment.save
    redirect "/questions/#{params[:id]}/answers"
  else
    @not_saved = true
    erb :answer_comment_form
  end
end

get '/questions/:id/comments/edit' do
  @question = Question.find(params[:id])
  erb :comment_edit_form
end

put '/questions/:id/comments' do
  comment = Comment.find(params[:id])
  comment.update(params[:comment])
  redirect "/questions/#{params[:id]}/answers"
end

get '/questions/:q'


