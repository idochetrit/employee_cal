class WorkdaysController < ApplicationController
  respond_to :json, :text

  def index
    respond_with Workday.all
  end

  def show
    respond_with Workday.find(params[:id])
  end

  def create
    respond_with Workday.create(workday_params)
  end

  def update
    respond_with Workday.update(params[:id], workday_params)
  end

  def destroy
    respond_with Workday.destroy(params[:id])
  end

  def workday_params
    params.require(:workday).permit(:employee_id, :start, :end)
  end
end
