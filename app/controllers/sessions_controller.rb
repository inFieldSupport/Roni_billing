class SessionsController < ApplicationController
    def create
        user = Employee.find_by(email: params[:session][:email])
        if user && user.authenticate(params[:session][:password])
          log_in(user)
        else
          render 'new'
        end
    end

    def logout
        log_out if logged_in?
        redirect_to root_path
    end
end
