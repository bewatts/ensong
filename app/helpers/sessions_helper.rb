module SessionsHelper
  
  def login_user(user)
    session[:session_token] = user.session_token
  end
  
  def logout_user
    current_user.demo_user? ? current_user.destroy : current_user.reset_session_token
    session[:session_token] = nil
  end
  
  def current_user
    User.find_by_session_token(session[:session_token])
  end
  
  def signed_in?
    !!current_user
  end
  
  def ensure_signed_in
    redirect_to new_session_url unless signed_in?
  end
  
  def user_is_signed_in_user?
    params[:id].to_i == current_user.id
  end
  
  def ensure_same_user
    redirect_to :back unless user_is_signed_in_user?
  end
end
