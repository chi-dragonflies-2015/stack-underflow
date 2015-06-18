#routes for updating votes on questions, answers, comments
#post routes because we are creating votes--we aren't updating. once a vote is cast, no taking it back.

#voting rules--can't vote on your own contribution. can't vote twice.

post '/questions/:id/votes' do
  #need to pass a negative one or positive one
  value = params[:value]
  user = User.find_by(id: session[:user_id])
  @question = Question.find_by(id: :id)
  if eligible_voter?
    #TODO reload the page to display the new vote
    @question.votes.create(user: user, value: value)
    erb :"questions/"
  else
    #NOTE: is this the correct redirect address?
    redirect to "questions/#{@question.id}"
  end
end

post '/answers/:id/votes' do
  #need to pass a negative one or positive one
  value = params[:value]
  user = User.find_by(id: session[:user_id])
  @answer = Answer.find_by(id: :id)
  if eligible_voter?
    #TODO reload the page to display the new vote
    @answer.votes.create(user: user, value: value)
    erb :"answers/"
  else
    #NOTE: is this the correct redirect address?
    redirect to "answers/#{@question.id}"
  end
end

post '/comments/:id/votes' do
  #need to pass a negative one or positive one
  value = params[:value]
  user = User.find_by(id: session[:user_id])
  @comment = Comment.find_by(id: :id)
  if eligible_voter?
    #TODO reload the page to display the new vote
    @comment.votes.create(user: user, value: value)
    erb :"comments/"
  else
    #NOTE: is this the correct redirect address?
    redirect to "comments/#{@question.id}"
  end
end

