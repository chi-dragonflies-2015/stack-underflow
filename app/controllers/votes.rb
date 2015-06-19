#routes for updating votes on questions, answers, comments
#post routes because we are creating votes--we aren't updating. once a vote is cast, no taking it back.

#voting rules--can't vote on your own contribution. can't vote twice.

#Routes, reloads, and redirects all need to be adapted to fit our current layout stuff.

post '/questions/:id/votes' do |id|
  redirect back unless logged_in?
  puts "*********************"
  puts "is an XHR request? #{request.xhr?}"
  puts "*********************"
  value = params[:value]
  user = current_user
  @question = Question.find_by(id: id)
  @answers = @question.answers
  if @question.eligible_voter?(user)
    @question.votes.create(user: user, value: value)
    if !request.xhr?
      erb :"questions/show"
    else
      status 200
      content_type :json
      {value: @question.reputation}.to_json
    end
  else
    if !request.xhr?
      redirect to "questions/#{@question.id}/answers"
    else
      status 200
      content_type :json
      {value: @question.reputation}.to_json
    end
  end

end

post '/answers/:id/votes' do |id|
  puts "$$$$$$$$$$$"
  puts logged_in?
  puts "$$$$$$$$$$$"
  redirect back unless logged_in?
  puts "*********************"
  puts "is an XHR request? #{request.xhr?}"
  puts "*********************"
  value = params[:value]
  user = current_user
  answer = Answer.find_by(id: id)
  @question = answer.question
  @answers = @question.answers
  if answer.eligible_voter?(user)
    answer.votes.create(user: user, value: value)
    if !request.xhr?
      #eligible and not ajax
      erb :"questions/show"
    else
      #eligible and ajax
      status 200
      content_type :json
      {value: answer.reputation}.to_json
    end
  else
    if !request.xhr?
      #ineligible and not ajax
      redirect to "questions/#{@question.id}/answers"
    else
      #ineligible and ajax
      status 200
      content_type :json
      {value: answer.reputation}.to_json    end
  end
end

post '/comments/:id/votes' do
  redirect back unless logged_in?
  value = params[:value]
  user = current_user
  @comment = Comment.find_by(id: :id)
  if @comment.commented_type == "Question"
    @question = Question.find_by(id: @comment.commented_id)
  else
    @question = Answer.find_by(id: @comment.commented_id).question
  end
    @answers = @question.answers
  if @comment.eligible_voter?(user)
    @comment.votes.create(user: user, value: value)
    if !request.xhr?
      erb :"questions/show"
    else
      @comment.reputation
    end
  else
    if !request.xhr?
      redirect to "questions/#{@question.id}/answers"
    else
      @comment.reputation
    end
  end
end



