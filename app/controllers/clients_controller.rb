class ClientsController < ApplicationController
    before_action :authenticate_user
    def index
        if params[:commit] == 'Search'
            if  !params[:client][:company_name].blank?
                @clients = Client.where("company_name LIKE ?", params[:client][:company_name].capitalize+"%")
            else
                @clients = Client.all
            end
            render 'index'
        else
        @clients = Client.all
        end

    end
    def show
        @client = Client.find(params[:id])
        @users = @client.users
        @standards = @client.standards

    end
end
