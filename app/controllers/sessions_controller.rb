class SessionsController < ApplicationController
    def create
        user = Employee.find_by(email: params[:session][:email])
        if user && user.authenticate(params[:session][:password])
          
          log_in(user)
        else
          flash[:danger] = "Invalid Email/Password"
          render 'new'
        end
    end

    def logout
        log_out if logged_in?
        flash[:success] = "Signed out successfully"
        redirect_to root_path
    end
end
