#routes for updating votes on questions, answers, comments
#post routes because we are creating votes--we aren't updating. once a vote is cast, no taking it back.

#voting rules--can't vote on your own contribution. can't vote twice.

post '/questions/:id/votes' do
  #need to pass a negative one or positive one
end

