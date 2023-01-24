class StandardsController < ApplicationController
    def update
        @standard = Standard.find(params[:id])
        if @standard.update(standard_params)
            redirect_to client_path(@standard.client)
        end
    end
    private
    def standard_params
        params.require(:standard).permit(:standard_rate, :active_users)
      end
end
