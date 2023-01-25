# frozen_string_literal: true

class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'User Updated Successfully'
    else
      flash[:danger] = @user.errors.full_messages[0]
    end
    redirect_to session.delete(:previous_request_url)
  end

  private

  def user_params
    params.require(:user).permit(:user_rate, :active_users)
  end
end
