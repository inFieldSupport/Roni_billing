# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authenticate_user
  def index
    @employees = Employee.all
  end
end
