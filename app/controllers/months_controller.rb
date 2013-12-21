class MonthsController < ApplicationController
  respond_to :json, :text

  def index
    respond_with  Area.areas_by_months
  end

  def show
    respond_with Area.areaItem_by_month(params[:id], true)
  end
end
