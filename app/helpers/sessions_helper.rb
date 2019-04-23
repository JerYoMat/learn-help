module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  
  
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def remember(user)
    user.remember #creates new token, hashes it and sets as remember_token via update_attribute
    # Sets an encrypted cookie value before sending it to the client which
    # prevent users from reading and tampering with its value.
    # The cookie is signed by your app's `secrets.secret_key_base` value.
    # It can be read using the encrypted method `cookies.encrypted[:name]`
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end 

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end


end
