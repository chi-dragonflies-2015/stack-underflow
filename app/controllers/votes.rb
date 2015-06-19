#routes for updating votes on questions, answers, comments
#post routes because we are creating votes--we aren't updating. once a vote is cast, no taking it back.

#voting rules--can't vote on your own contribution. can't vote twice.

#Routes, reloads, and redirects all need to be adapted to fit our current layout stuff.

post '/questions/:id/votes' do |id|
  redirect back unless logged_in?

  if !request.xhr?
    value = params[:value]
    user = current_user
    @question = Question.find_by(id: id)
    @answers = @question.answers
    if @question.eligible_voter?(user)
      @question.votes.create(user: user, value: value)
      erb :"questions/show"
    else
      redirect to "questions/#{@question.id}/answers"
    end
  else

  end
end

post '/answers/:id/votes' do |id|
  redirect back unless logged_in?

  if !request.xhr?
    value = params[:value]
    user = current_user
    answer = Answer.find_by(id: id)
    @question = answer.question
    @answers = @question.answers
    if answer.eligible_voter?(user)
      answer.votes.create(user: user, value: value)
      erb :"questions/show"
    else
      redirect to "questions/#{@question.id}/answers"
    end
  else

  end
end

post '/comments/:id/votes' do
  redirect back unless logged_in?

  if !request.xhr?
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
      erb :"questions/show"
    else
      redirect to "questions/#{@question.id}/answers"
    end
  else

  end
end



