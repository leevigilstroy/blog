module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Remembers a user in a persistent session. - uses the remember method in user model -user.remember
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
   #   raise       # The tests still pass, so this branch is currently untested.
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  #boolean check on current user
  def current_user?(user)
    user == current_user
  end
  
  
  # Forgets a persistent session.
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
  
  def logged_in?
    !current_user.nil?
  end
  
  # Redirects to stored location (or to the default).  To implement the forwarding friednly itself, we use the redirect_back_or method to redirect to the requested URL if it exists, or some default URL otherwise
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.  The store_location method in Listing 9.27 puts the requested URL in the session variable under the key :forwarding_url, but only for a GET request
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
end
