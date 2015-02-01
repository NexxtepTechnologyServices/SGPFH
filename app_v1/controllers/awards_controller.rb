class AwardsController < ApplicationController
  before_action :set_award, only: [:show, :edit, :update, :destroy]

  # GET /awards
  # GET /awards.json
  def index
    @awards = Award.all
  end

  # GET /awards/1
  # GET /awards/1.json
  def show
  end

  # GET /awards/new
  def new
    @award = Award.new
    @award.patient_id = (session[:patient].present?) ? session[:patient] : nil
    @award.save
    session[:award] = @award.id
  end

  # GET /awards/1/edit
  def edit
  end

  # POST /awards
  # POST /awards.json
  def create
    @award = Award.new(award_params)

    respond_to do |format|
      if @award.save
        format.html { redirect_to patients_path, notice: 'Award was successfully created.' }
        format.json { render :show, status: :created, location: @award }
      else
        format.html { render :new }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /awards/1
  # PATCH/PUT /awards/1.json
  def update
    respond_to do |format|
      if @award.update(award_params)
        format.html { redirect_to patients_path, notice: 'Award was successfully updated.' }
        format.json { render :show, status: :ok, location: @award }
      else
        format.html { render :edit }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awards/1
  # DELETE /awards/1.json
  def destroy
    @award.destroy
    respond_to do |format|
      format.html { redirect_to awards_url, notice: 'Award was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_award_form
    tid = params[:id].to_i
    case tid
    when 1
      controller = "transports"
      @transport = Transport.new
    when 2
      controller = "medications"
      @medication = Medication.new
    when 3
      controller = "devices"
      @device = Device.new
    when 4
      controller = "supplements"
      @supplement = Supplement.new
    #when 5
      #url = new new_other_url
    end
    respond_to do |format|
      format.html { render :partial => "#{controller}/form" }
      format.json { render :json => {:location => controller} }
    end
  end

  def set_paid
    o = nil
    sub = params[:sub_type] 
    
      if sub == "Transport"
        o = Transport.find(params[:id])
      elsif sub == "Medication"
        o = Medication.find(params[:id])
      elsif sub == "Device"
        o = Device.find(params[:id])
      elsif sub == "Supplement"
        o = Supplement.find(params[:id])
      end
      o.paid = true
      o.save
      fu = o.award.funds_used
      fr = o.award.funds_remaining
    render :json => { :id => o.award.id, :funds_used => fu, :funds_remaining => fr }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_award
      @award = Award.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def award_params
      params.require(:award).permit(:patient_id, :award_type, :total_requested, :total_granted, :description, :vendor)
    end
end
