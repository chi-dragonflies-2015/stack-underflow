get '/' do
  @questions = Question.limit(10)
  erb :index
end
