# frozen_string_literal: true

class StandardsController < ApplicationController
  def update
    @standard = Standard.find(params[:id])
    if @standard.update(standard_params)
      flash[:success] = 'Standard Updated Successfully'
    else
      flash[:danger] = @standard.errors.full_messages[0]
    end
    redirect_to session.delete(:previous_request_url)
  end

  private

  def standard_params
    params.require(:standard).permit(:standard_rate, :active_users)
  end
end
