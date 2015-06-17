helpers do

  def current_user
    User.new(params[:login])
  end

  def logout_user
    sessions[:user_id] = nil
  end

  def existing_user?
    if User.find_by(email: current_user[:email])
      true
    else
      false
    end
  end

end
