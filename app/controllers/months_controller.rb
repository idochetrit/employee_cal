class MonthsController < ApplicationController
  respond_to :json

  def index
    respond_with  Area.areas_by_months
  end

  def show
  end
end
