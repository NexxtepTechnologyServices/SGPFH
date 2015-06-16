class AwardsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_award, only: [:show, :edit, :update, :destroy]
  # GET /awards
  # GET /awards.json
  def index

    start_date = (params[:start_date].present?) ? params[:start_date] : "1970-01-01 00:00:00"
    end_date = (params[:end_date].present?) ? params[:end_date] : "3000-12-31 00:00:00"
    @display_start_date = (params[:start_date].present?) ? params[:start_date] : ""
    @display_end_date = (params[:end_date].present?) ? params[:end_date] : ""
    values = {start_date: start_date, end_date: end_date}
    conditions = ["date_of_service >= :start_date","date_of_service <= :end_date"]
    @unpaid = (params[:search_type] == "unpaid")
    if params[:query].present? 
      @query = params[:query]      
      values[:vendor] = @query
      conditions << "vendor = :vendor"
      #@awards = Award.where("vendor = ? AND date_of_service >= ? AND date_of_service <= ?", params[:query],start_date,end_date).order(created_at: :desc)
    #else
      #@awards = Award.where("date_of_service >= ? AND date_of_service <= ?", start_date,end_date).order(created_at: :desc)
    end
    @awards = Award.includes(:patient).where(conditions.join(" AND "), values)
    @awards.to_a.reject! { |a| a.patient.nil? }
    @awards = @awards.sort_by { |a| a.patient.last_name }
    #@vendors = Award.all.map {|a| [a.vendor, a.vendor]};
    @vendors = Award.uniq.pluck(:vendor)
    @vendors.unshift(["All", ""])
  end

  # GET /awards/1
  # GET /awards/1.json
  def show
  end

  # GET /awards/new
  def new
    @patient = Patient.find(session[:patient])
    @award = Award.new
    #@award.patient_id = (session[:patient].present?) ? session[:patient] : nil
    #@award.save
    #session[:award] = @award.id
  end

  # GET /awards/1/edit
  def edit
    @patient = @award.patient
    
  end

  # POST /awards
  # POST /awards.json
  def create
    @award = Award.new(award_params)
    respond_to do |format|
      if @award.save
        a_data = JSON.parse params[:json_string]
        a_data.each do |a|
          @item = get_new_award_item(@award, a)
        end
        AwardMailer.approval_request(@award)
        if current_user.admin
          format.html { redirect_to patient_path(@award.patient), notice: 'Award was successfully created.' }
        else
          format.html { redirect_to new_patient_path, notice: 'Award was successfully created.' }
        end
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
        format.html { redirect_to patient_path(@award.patient), notice: 'Award was successfully updated.' }
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
    p = @award.patient
    @award.destroy
    p.reload
    respond_to do |format|
      format.html { redirect_to awards_url, notice: 'Award was successfully destroyed.' }
      format.json { render json: {:award => @award, :lifetime => p.lifetime_total, :year => p.funds_this_year, :quarter => p.funds_this_quarter } }
    end
  end

  def create_comment
    award = Award.find(params[:id])
    comment = Comment.new
    comment.content = params[:content]
    comment.user = current_user
    comment.award = award
    if comment.save
      redirect_to patient_url(award.patient), notice: 'Comment added to the award'
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
      l = o.award.patient.lifetime_total
      y = o.award.patient.funds_this_year
      q = o.award.patient.funds_this_quarter
    render :json => { :id => o.award.id, :funds_used => fu, :funds_remaining => fr, :lifetime => l, :year => y, :quarter => q }
  end

  def approve_email()
    affiliate = Affiliate.find_by(slug: params[:hash])
    award = Award.find(params[:award])
    app = award.approvals.where(affiliate_id: affiliate.id)
    app.approval_method = "email"
    app.save
    approval.save
    render :json => { "status" => "Approved" }
  end

  def approve_login()
    affiliate = current_user.affiliate
    award = Award.find(params[:award])
    app = award.approvals.where(affiliate_id: current_user.affiliate.id)
    app.approval_method = "login"
    app.save
    render :json => { "status" => "Approved" }
  end

  def approve_admin()
    award = Award.find(params[:id])
    award.approvals.each { |a| a.approval_method = "admin"; a.save; }
    render :json => { "status" => "Approved" }
  end

  private

    def get_new_award_item(award, data)
      case @award.award_type
        when 1
          item = Transport.new
        when 2
          item = Medication.new
        when 3
          item = Device.new
        when 4
          item = Supplement.new
        #when 5
          #url = new new_other_url
        end
        item.make(award, data)
        puts item
        item.save
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_award
      @award = Award.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def award_params
      params[:award][:total_granted] = params[:award][:total_requested]
      params[:award][:date_of_service] = format_dates(params[:award][:date_of_service])
      params.require(:award).permit(:patient_id, :award_type, :total_requested, :total_granted, :description, :vendor, :date_of_service)
    end
end
