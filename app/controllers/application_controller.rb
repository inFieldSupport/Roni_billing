# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  before_action :store_location

  def index
    return if logged_in?

    redirect_to login_path
  end

  def current_user
    return unless session[:user_email]

    @current_user = Employee.find_by(email: session[:user_email])
  end

  def log_in(user)
    session[:user_email] = user.email
    @current_user = user
    flash[:success] = 'Signed In successfully'
    redirect_to clients_path
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_email)
    @current_user = nil
  end

  def authenticate_user
    redirect_to login_path unless logged_in?
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:previous_request_url] = session[:current_request_url]
    session[:current_request_url] = request.url
  end
end
