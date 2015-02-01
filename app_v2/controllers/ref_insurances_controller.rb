class RefInsurancesController < ApplicationController
  before_action :set_ref_insurance, only: [:show, :edit, :update, :destroy]

  # GET /ref_insurances
  # GET /ref_insurances.json
  def index
    @ref_insurances = RefInsurance.all
  end

  # GET /ref_insurances/1
  # GET /ref_insurances/1.json
  def show
  end

  # GET /ref_insurances/new
  def new
    @ref_insurance = RefInsurance.new
  end

  # GET /ref_insurances/1/edit
  def edit
  end

  # POST /ref_insurances
  # POST /ref_insurances.json
  def create
    @ref_insurance = RefInsurance.new(ref_insurance_params)

    respond_to do |format|
      if @ref_insurance.save
        format.html { redirect_to @ref_insurance, notice: 'Ref insurance was successfully created.' }
        format.json { render :show, status: :created, location: @ref_insurance }
      else
        format.html { render :new }
        format.json { render json: @ref_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ref_insurances/1
  # PATCH/PUT /ref_insurances/1.json
  def update
    respond_to do |format|
      if @ref_insurance.update(ref_insurance_params)
        format.html { redirect_to @ref_insurance, notice: 'Ref insurance was successfully updated.' }
        format.json { render :show, status: :ok, location: @ref_insurance }
      else
        format.html { render :edit }
        format.json { render json: @ref_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ref_insurances/1
  # DELETE /ref_insurances/1.json
  def destroy
    @ref_insurance.destroy
    respond_to do |format|
      format.html { redirect_to ref_insurances_url, notice: 'Ref insurance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ref_insurance
      @ref_insurance = RefInsurance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ref_insurance_params
      params.require(:ref_insurance).permit(:name)
    end
end
