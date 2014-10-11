class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = policy_scope(Employee).all
    respond_with(@employees)
  end

  def show
    respond_with(@employee)
  end

  def new
    @employee = Employee.new
    respond_with(@employee)
  end

  def edit
  end

  def create
    @employee = current_user.employees.create(employee_params)
    respond_with(@employee)
  end

  def update
    @employee.update(employee_params)
    respond_with(@employee)
  end

  def destroy
    @employee.destroy
    respond_with(@employee)
  end

  private
    def set_and_authorize_employee
      @employee = Employee.find(params[:id])
      authorize @employee
    end

    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :salary)
    end
end
