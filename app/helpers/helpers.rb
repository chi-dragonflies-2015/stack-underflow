helpers do

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logout_user
    session[:user_id] = ""
  end

  def existing_user?
    if User.find_by(email: current_user[:email])
      true
    else
      false
    end
  end

  def logged_in?
    !session[:user_id].nil?
  end



end
