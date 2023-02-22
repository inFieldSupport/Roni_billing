# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :authenticate_user
  before_action :set_default_values , only: :show
  def index
    if params[:commit] == 'Search'
      @clients = if !params[:client][:company_name].blank?
                   Client.where('company_name LIKE ?', "#{params[:client][:company_name].capitalize}%")
                 else
                   Client.all
                 end
      render 'index'
    else
      @clients = Client.all
    end
  end

  def show
    
    
    @months = %w[January February March April May June July August September October November
                 December]
    @years = 2019.upto(DateTime.now.strftime('%Y').to_i).map { |year| year }
    @year = DateTime.now.strftime("%Y")
    @month = DateTime.now.strftime("%B")
    if params[:search]
      if params[:search][:year].blank? 
        @year = DateTime.now.strftime("%Y")
      else
        @year = params[:search][:year]
      end
      if params[:search][:month].blank? 
        @month = DateTime.now.strftime("%B")
      else
        @month = params[:search][:month]
      end

    if "#{@month},#{@year}".to_date > DateTime.now
      flash[:danger] = "Cannot access upcoming dates"
     redirect_to session.delete(:previous_request_url)
    else
    @users = @client.users.where(month:@month,year:@year).order('id')
    @standards =  @client.standards.where(month:@month,year:@year).order('id')
    @users_bill = @client.calculate_user_bill(@client, @month, @year)
    @standards_bill = @client.calculate_standard_bill(@client, @month, @year)
    @subtotal = @client.calculate_subtotal(@users_bill, @standards_bill)
    @tax = @client.calculate_tax(@subtotal)
    @total = @client.calculate_total(@subtotal, @tax)
    end
  end
  end

  private



  def set_default_values
    @client = Client.find(params[:id])
    @users = @client.users.where(month: DateTime.now.strftime('%B'), year: DateTime.now.strftime('%Y')).order('id')
    @standards = @client.standards.where(month: DateTime.now.strftime('%B'),
                                         year: DateTime.now.strftime('%Y')).order('id')

    @users_bill = @client.calculate_user_bill(@client, DateTime.now.strftime('%B'), DateTime.now.strftime('%Y'))
    @standards_bill = @client.calculate_standard_bill(@client, DateTime.now.strftime('%B'),
                                                      DateTime.now.strftime('%Y'))
    @subtotal = @client.calculate_subtotal(@users_bill, @standards_bill)
    @tax = @client.calculate_tax(@subtotal)
    @total = @client.calculate_total(@subtotal, @tax)
  end
end
