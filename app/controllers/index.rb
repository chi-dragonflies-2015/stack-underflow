get '/' do
  @questions = Question.all
  @answers = Answer.all
  @comments = Comment.all
  erb :index
end


delete '/logout' do
  logout_user
end

get '/questions' do
  @questions = Question.all
  erb :'questions/index'
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

get '/questions/:id/answers' do  |id|
  @question = Question.find(id)
  @answers = @question.answers
  erb :'/questions/show'
end

get '/questions/:id/edit' do #secure
  redirect "/questions/#{params[:id]}" if !session[:user_id]
  @question = Question.find(params[:id])
  erb :question_edit_form

end

put '/questions/:id' do #secure
  redirect "/questions/#{params[:id]}" if !session[:user_id]
  question = Question.find(params[:id])
  question.update(params[:question])
  redirect "/questions/#{params[:id]}/answers"

end

delete '/questions/:id' do
  question = Question.find(params[:id])
  question.destroy
  redirect "/questions"
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
  redirect '/questions/#{params[:id]}/answers' if !session[:user_id]
  @question = Question.find(params[:id])
  erb :answer_form
end

post '/questions/:id/answers' do |id|
  answer = Answer.new(params[:answer])
  question = Question.find(id)

  if answer
    question.answers << answer
    redirect "/questions/#{id}/answers"
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
  question = Question.find(params[:id])
  if comment
    question.comments << comment
    redirect "/questions/#{params[:id]}/answers"
  else
    @not_saved = true
    erb :answer_comment_form
  end
end


get '/questions/:question_id/comments/:comment_id/edit' do
  @question = Question.find(params[:question_id])
  @comment = Comment.find(params[:comment_id])
  erb :comment_edit_form
end

put '/questions/:question_id/comments/:comment_id' do
  p ">" * 50
  comment = Comment.find_by(params[:comment_id])
  comment.update(params[:comment])
  redirect "/questions/#{params[:question_id]}/answers"
end

get '/questions/:question_id/answers/:answer_id/edit' do
  @question = Question.find(params[:question_id])
  @answer = Answer.find(params[:answer_id])
  erb :answer_edit_form
end



# Begin Jason's testing routes

get '/questions/test' do
  puts 'HI'
  @questions = Question.all
  puts @questions.length
  erb :"questions/index"
end

get '/questions/show/test' do
  @question = Question.find(2)
  @answers = @question.answers
  erb :"questions/show"
end

# End Jason's testing routes

get '/questions/:id' do
end


put '/questions/:question_id/answers/:answer_id' do
  answer = Answer.find(params[:answer_id])
  answer.update(params[:answer])
  redirect "/questions/#{params[:question_id]}/answers"
end











