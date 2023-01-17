class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :logged_in?


    def index
      if !logged_in?
        redirect_to login_path
      end
    end

    def current_user
      if session[:user_email]
        @current_user  = Employee.find_by(email:session[:user_email])
      end
    end 

    def log_in(user)
        session[:user_email] = user.email
        @current_user = user
        redirect_to root_path
    end

    def logged_in?
        !current_user.nil?
    end

    def log_out
        session.delete(:user_email)
        @current_user = nil
    end

    def authenticate_user 
      redirect_to login_path unless logged_in?
    end
  
end
