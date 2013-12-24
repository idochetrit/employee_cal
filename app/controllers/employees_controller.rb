class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :check_format

  respond_to :json

  # GET /employees
  # GET /employees.json
  def index
    respond_with Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    respond_with Employee.find params[:id]
  end


  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    @employee.update(employee_params)
    render json: @employee.as_json
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    respond_with @employee.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :grade, :area_id)
    end

    def check_format
      render :nothing => true, :status => 406 unless params[:format] == 'json'
    end
end
