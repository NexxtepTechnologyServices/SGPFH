class PatientsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  # GET /patients
  # GET /patients.json
  def index
    unless current_user.admin
      redirect_to new_patient_path
    end
    if params[:query].present?
      @patients = Patient.search(params[:query], load: true)
      @patients = @patients.sort_by { |p| p.last_name }
    else
      @patients = Patient.order(last_name: :desc)
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    session[:patient] = @patient.id
    @awards = Hash.new
    @patient.awards.each do |a|
      @awards[a.award_type] = Array.new unless @awards.has_key?(a.award_type)
      @awards[a.award_type] << a
    end
    @isAdmin = (current_user.admin)
  end
  def print
    @patient = Patient.find(params[:id])
    session[:patient] = @patient.id
    @awards = Hash.new
    @patient.awards.each do |a|
      @awards[a.award_type] = Array.new unless @awards.has_key?(a.award_type)
      @awards[a.award_type] << a
    end
    @isAdmin = (current_user.admin)
  end
  def pdf_print
    @patient = Patient.find(params[:id])
    @awards = @patient.awards.where(award_type: params[:aType])
    @awards = @awards.reject { |a| a.paid? }
    if @awards.blank? 
      redirect_to :back 
      return
    end
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "#{@awards.first.award_type_text}_#{DateTime.now}", :disposition => 'inline', :template => 'patients/pdf_print.pdf.erb', :layout => false
      end
    end
  end
  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
    @patient.lifetime_total = 0.0
    respond_to do |format|
      if @patient.save
        session[:patient] = @patient.id
        format.html { redirect_to new_award_path, notice: 'Patient Saved!' }
        #format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
          if current_user.admin
            format.html { redirect_to @patient, notice: 'Patient Data was successfully updated.' }
          else
            session[:patient] = @patient.id
            format.html { redirect_to new_award_path, notice: 'Patient Saved!' }
          end
          format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.deleted = DateTime.now
    @patient.save
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { render json: @patient }
    end
  end

  def lookup
    params[:birthday] = format_dates(params[:birthday])
    #@patient = Patient.where("first_name = ? AND middle_name = ? AND last_name = ? and birthday = ?", params[:first_name],params[:middle_name],params[:last_name],params[:birthday])
    if params[:middle_name].blank?
      @patient = Patient.where("first_name = ? AND last_name = ? AND birthday = ?", params[:first_name], params[:last_name],params[:birthday])
    else
      @patient = Patient.where("first_name = ? AND middle_name = ? AND last_name = ? AND birthday = ?", params[:first_name],params[:middle_name],params[:last_name],params[:birthday])
    end
    respond_to do |format|
      unless @patient.blank?
        format.json { render json: @patient, status: :ok}
      else
        format.json { render json: "ERROR", status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end
#    def format_dates
#      if params.key?('birthday')
#        p = params[:birthday].split("/")
#        params[:birthday] = "#{p[2]}-#{p[1]}-#{p[0]}"
#      elsif params.key?('patient') && params[:patient].key?('birthday')
#        p = params[:patient][:birthday].split("/")
#        params[:patient][:birthday] = "#{p[2]}-#{p[1]}-#{p[0]}"
#      end 
#    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params[:patient][:birthday] = format_dates(params[:patient][:birthday])
      params.require(:patient).permit(:first_name, :last_name, :middle_name, :birthday, :address1, :address2, :city, :state, :zip, :home_phone, :work_phone, :diagnosis, :diagnosis_confirmed, :low_income, :income_sources, :advocate_firstname, :advocate_lastname, :advocate_phone, :advocate_email)
    end
end
