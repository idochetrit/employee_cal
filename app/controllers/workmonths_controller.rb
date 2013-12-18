class WorkmonthsController < ApplicationController
  respond_to :json

  # GET /workmonths
  # GET /workmonths.json
  def index
    respond_with @workmonths = Workmonth.all
  end

  # GET /workmonths/1
  # GET /workmonths/1.json
  def show
  end

  # POST /workmonths
  # POST /workmonths.json
  def create
    @workmonth = Workmonth.new(workmonth_params)
    if @workmonth.save
      respond_with @workmonth
    end
  end

  # PATCH/PUT /workmonths/1
  # PATCH/PUT /workmonths/1.json
  def update
    respond_with  @workmonth.update(workmonth_params)
  end

  # DELETE /workmonths/1
  # DELETE /workmonths/1.json
  def destroy
    respond_with @workmonth.destroy
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
