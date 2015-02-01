class ReferralsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_referral, only: [:show, :edit, :update, :destroy]
  # GET /referrals
  # GET /referrals.json
  def index
    unless current_user.admin
      redirect_to new_referral_path
    end
    if params[:query].present?
      @referrals = Referral.search(params[:query], load: true)
    else
      @referrals = Referral.order(created_at: :desc)
    end
  end

  # GET /referrals/1
  # GET /referrals/1.json
  def show
    @user = User.find(@referral.app_sent_by) if @referral.app_sent_by.present?
    @doctor = RefPysician.find(@referral.referring_physician_id)
  end

  # GET /referrals/new
  def new
    @referral = Referral.new
    @doctors = RefPysician.all
  end

  # GET /referrals/1/edit
  def edit
  end

  # POST /referrals
  # POST /referrals.json
  def create
    @referral = Referral.new(referral_params)
    respond_to do |format|
      if @referral.save
        session[:referral] = @referral.id
        format.html { redirect_to new_ref_med_path, notice: 'Referral Saved!' }
        format.json { render :show, status: :created, location: @referral }
      else
        format.html { render :new }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referrals/1
  # PATCH/PUT /referrals/1.json
  def update
    respond_to do |format|
      if @referral.update(referral_params)
        format.html { redirect_to @referral, notice: 'Referral was successfully updated.' }
        format.json { render :show, status: :ok, location: @referral }
      else
        format.html { render :edit }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referrals/1
  # DELETE /referrals/1.json
  def destroy
    @referral.destroy
    respond_to do |format|
      format.html { redirect_to referrals_url, notice: 'Referral was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_app_sent
    @referral = Referral.find(params[:id])
    @referral.app_sent = DateTime.now
    @referral.app_sent_by = current_user.id
    @referral.save()
    respond_to do |format|
      format.json { render json: @referral }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referral
      @referral = Referral.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def referral_params
      params.require(:referral).permit(:advocate_email, :referring_physician_id, :prefix, :firstname, :middlename, :lastname, :address, :city, :state, :zip, :home_phone, :work_phone, :contact_name, :contact_phone, :id_num, :date_of_birth, :gender, :married, :employed, :citizen, :household_size, :income, :income_sources, :ref_med)
    end
end
