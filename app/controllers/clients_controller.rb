# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :authenticate_user
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
    @months = %w[January February March April May June July August September October November
                 December]
    @years = 2019.upto(DateTime.now.strftime('%Y').to_i).map { |year| year }
    @year = DateTime.now.strftime("%Y")
    @month = DateTime.now.strftime("%B")
    if params[:search]
      if !params[:search][:year] 
        @year = DateTime.now.strftime("%Y")
      else
        @year = params[:search][:year]
      end
      if !params[:search][:month] 
        @month = DateTime.now.strftime("%B")
      else
        @month = params[:search][:month]
      end
    if "#{@month},#{@year}" > DateTime.now.strftime("%B,%Y")
      flash[:danger] = "Cannot access upcoming dates"
     redirect_to session.delete(:previous_request_url)
    else
    @users = get_users
    @standards = get_standards
    @users_bill = get_user_bill(@client)
    @standards_bill = get_standard_bill(@client)
    @subtotal = @client.calculate_subtotal(@users_bill, @standards_bill)
    @tax = @client.calculate_tax(@subtotal)
    @total = @client.calculate_total(@subtotal, @tax)
    end
  end
  end

  private

  def get_users
    users = @client.users
    users = if params[:search][:month].present?
              users.where(['month = ?', params[:search][:month]])
            else
              users.where(['month = ?', DateTime.now.strftime('%B')])
            end
    users = if params[:search][:year].present?
              users.where(['year = ?', params[:search][:year]])
            else
              users.where(['year = ?', DateTime.now.strftime('%Y')])
            end
    users.order('id')
  end

  def get_standards
    standards = @client.standards
    standards = if params[:search][:month].present?
                  standards.where(['month = ?', params[:search][:month]])
                else
                  standards.where(['month = ?', DateTime.now.strftime('%B')])
                end
    standards = if params[:search][:year].present?
                  standards.where(['year = ?', params[:search][:year]])
                else
                  standards.where(['year = ?', DateTime.now.strftime('%Y')])
                end
    standards.order('id')
  end

  def get_user_bill(client)
    user_bill = 0
    if params[:search][:month].present? && params[:search][:year].present?
      user_bill = client.calculate_user_bill(client, params[:search][:month], params[:search][:year])
    elsif params[:search][:month].present? && !params[:search][:year].present?
      user_bill = client.calculate_user_bill(client, params[:search][:month], DateTime.now.strftime('%Y'))
    elsif !params[:search][:month].present? && params[:search][:year].present?
      user_bill = client.calculate_user_bill(client, DateTime.now.strftime('%B'), params[:search][:year])
    elsif !params[:search][:month].present? && !params[:search][:year].present?
      user_bill = client.calculate_user_bill(client, DateTime.now.strftime('%B'), DateTime.now.strftime('%Y'))
    end
    user_bill
  end

  def get_standard_bill(client)
    standard_bill = 0
    if params[:search][:month].present? && params[:search][:year].present?
      standard_bill = client.calculate_standard_bill(client, params[:search][:month], params[:search][:year])
    elsif params[:search][:month].present? && !params[:search][:year].present?
      standard_bill = client.calculate_standard_bill(client, params[:search][:month],
                                                     DateTime.now.strftime('%Y'))
    elsif !params[:search][:month].present? && params[:search][:year].present?
      standard_bill = client.calculate_standard_bill(client, DateTime.now.strftime('%B'),
                                                     params[:search][:year])
    elsif !params[:search][:month].present? && !params[:search][:year].present?
      standard_bill = client.calculate_standard_bill(client, DateTime.now.strftime('%B'),
                                                     DateTime.now.strftime('%Y'))
    end
    standard_bill
  end
end
