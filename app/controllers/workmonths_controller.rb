class WorkmonthsController < ApplicationController
  before_action :set_workmonth, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => :create 


  # GET /workmonths
  # GET /workmonths.json
  def index
    @workmonths = Workmonth.all
  end

  # GET /workmonths/1
  # GET /workmonths/1.json
  def show
  end

  # GET /workmonths/new
  def new
    @employee = Employee.find params[:employee_id]
    @workmonth = @employee.workmonths.build
  end

  # GET /workmonths/1/edit
  def edit
  end
  
  # POST /workmonths
  # POST /workmonths.json
  def create
    logger.debug workmonth_params
    @workmonth = Workmonth.new(workmonth_params)

    respond_to do |format|
      if @workmonth.save
        format.html { redirect_to employees_url, notice: 'Workmonth was successfully created.' }
        format.json { render action: 'show', status: :created, location: @workmonth }
      else
        format.html { render action: 'new' }
        format.json { render json: @workmonth.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workmonths/1
  # PATCH/PUT /workmonths/1.json
  def update
    respond_to do |format|
      if @workmonth.update(workmonth_params)
        format.html { redirect_to @workmonth, notice: 'Workmonth was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @workmonth.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workmonths/1
  # DELETE /workmonths/1.json
  def destroy
    @workmonth.destroy
    respond_to do |format|
      format.html { redirect_to workmonths_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workmonth
      @workmonth = Workmonth.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workmonth_params
      params.require(:workmonth).permit!
    end
end
