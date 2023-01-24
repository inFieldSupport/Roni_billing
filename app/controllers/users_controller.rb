class UsersController < ApplicationController
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:succes] = "Signed In successfully"
            redirect_to client_path(@user.client)
        end
    end
    private
    def user_params
        params.require(:user).permit(:user_rate, :active_users)
      end
end
