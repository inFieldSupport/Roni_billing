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
        @users = @client.users.order("id")
        @standards = @client.standards.order("id")
        @users_bill = @client.calculate_user_bill(@client)
        @standards_bill = @client.calculate_standard_bill(@client)
        @subtotal =  @client.calculate_subtotal(@users_bill,@standards_bill)
        @tax = @client.calculate_tax(@subtotal)
        @total = @client.calculate_total(@subtotal,@tax)
    end
end
