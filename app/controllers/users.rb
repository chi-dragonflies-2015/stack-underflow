get '/users' do
  @users = User.all
  erb :"users/index"
end

post "/users/new" do

  if params[:password] != params[:password_2]
    #throw an error with ajax or something if this gets passed
    redirect to '/users/new'
  else
    user = User.new(params[:user])
    user.password = params[:password]

    if user.save
      session[:user_id] = user.id
      redirect to '/'
    else
      erb :"/users/new"
    end
  end
end

get '/users/new' do
  erb :"/users/new"
end

get '/users/:id' do |id|
  @user = User.find_by(id: id)
  erb :"/users/show"
end

get '/users/:id/edit' do |id|
  @user = User.find_by(id: id)
  erb :"/users/edit"
end

put '/users/:id' do |id|
  @user = User.find_by(id: id)
  redirect back unless @user == current_user
  if !params[:password].nil?
    if params[:password] != params[:password_2]
      #throw an error with ajax or something if this gets passed
      redirect to "/users/#{@user.id}"
    else
      @user.password = params[:password]
    end
  end
  @user.update_attributes(params[:user])
  redirect "/users/#{@user.id}"
end

delete '/users/:id' do |id|
  user = User.find_by(id: id)
  redirect back unless current_user == current_user
  user_questions = Question.where(user: user)
  user_answers = Answer.where(user: user)
  user_comments = Comment.where(user: user)
  user_posts = user_questions + user_answers + user_comments

  user_posts.each do |post|
    post.user = nil
  end

  user.destroy
  logout_user
  redirect '/'
end

