class VacationsController < ApplicationController
  respond_to :json

  def index
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
      respond_with wm
    else
      respond_with status: :error
    end
  end

  def update
  end

  def destroy
  end
end
