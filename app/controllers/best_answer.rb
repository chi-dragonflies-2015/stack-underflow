put '/questions/:id/best_answer' do |id|
  question = Question.find_by(id: id)
  question.best_answer = Answer.find_by(id: params[:best_answer])
  question.save
  redirect "/questions/#{id}/answers"
end

# best answer logic

# on a question page, show a button form  next to every answer to name it as best answer

# that button should only appear when session[:user_id] is the same as @question.user.id

# pressing that button should send a put method request to /questions/:id/best_answer, with the id of the answer chosen.

# this route will change the best_answer of the question to the passed id of the answer chosen.

# display a star or something next to it on the re-render

# <form name="best_answer" method="post" action="/questions/<%= @question.id/best_answer">
#   <input type="hidden" name="_method" value="put">
#   <input type="hidden" name="best_answer" value="<%= answer.id%>">
#   <input type="submit" value="best answer">
# </form>