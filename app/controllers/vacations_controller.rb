class VacationsController < ApplicationController
  respond_to :json

  def index
    @employee = Employee.find params[:employee_id]
    wm = @employee.workmonths.vacation
    respond_with wm
  end

  def show
  end

  def create
    @employee = Employee.find params[:employee_id]
    wm = @employee.workmonths.where({month: params[:month]}).first
    unless wm.nil?
      wm.start_vacation = params[:start_vacation]
      wm.end_vacation = params[:end_vacation]
      wm.vacation = true
      wm.save
      respond_with wm
    else
      respond_with "employee not set to work in this month..."
    end
  end

  def update
  end

  def destroy
    @employee = Employee.find params[:employee_id]
    wm = @employee.workmonths.where({month: params[:month]}).first
    unless wm.nil?
      wm.start_vacation = nil
      wm.end_vacation = nil
      wm.vacation = false
      wm.save
      respond_with wm
    else
      respond_with "error has ocurred"
    end
  end
end
