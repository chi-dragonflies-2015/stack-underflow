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
