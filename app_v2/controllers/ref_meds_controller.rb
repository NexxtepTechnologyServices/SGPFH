class RefMedsController < ApplicationController
  before_action :set_ref_med, only: [:show, :edit, :update, :destroy]

  # GET /ref_meds
  # GET /ref_meds.json
  def index
    @ref_meds = RefMed.all
  end

  # GET /ref_meds/1
  # GET /ref_meds/1.json
  def show
  end

  # GET /ref_meds/new
  def new
    @referral = Referral.find(session[:referral]) if session[:referral].present?
    @referral = Referral.find(params[:referral_id]) if params[:referral_id].present?
    session[:referral] = @referral.id
    @ref_med = RefMed.new
  end

  # GET /ref_meds/1/edit
  def edit
  end

  # POST /ref_meds
  # POST /ref_meds.json
  def create
    if params[:ref_med][:id].present? 
      @ref_med = RefMed.find(params[:ref_med][:id])
      @ref_med.update(ref_med_params)
    else
      @ref_med = RefMed.new(ref_med_params)
    end 
    if session[:referral].present?
      @ref_med.referral_id = session[:referral] 
    else
      format.html { render :new }
      format.json { render json: @ref_med.errors, status: :unprocessable_entity }
      return
    end
    respond_to do |format|
      if @ref_med.save
        format.html { redirect_to @ref_med, notice: 'Ref med was successfully created.' }
        format.json { render :show, status: :created, location: @ref_med }
      else
        format.html { render :new }
        format.json { render json: @ref_med.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ref_meds/1
  # PATCH/PUT /ref_meds/1.json
  def update
    respond_to do |format|
      if @ref_med.update(ref_med_params)
        format.html { redirect_to @ref_med, notice: 'Ref med was successfully updated.' }
        format.json { render :show, status: :ok, location: @ref_med }
      else
        format.html { render :edit }
        format.json { render json: @ref_med.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ref_meds/1
  # DELETE /ref_meds/1.json
  def destroy
    @ref_med.destroy
    respond_to do |format|
      format.html { redirect_to ref_meds_url, notice: 'Ref med was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ref_med
      @ref_med = RefMed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ref_med_params
      #params[:ref_med][:referral_id] = session[:referral].id if session[:referral]
      params.require(:ref_med).permit(:drug, :icd9, :diagnosis, :doscage, :sig, :dispense, :refills, :referral_id)
    end
end
