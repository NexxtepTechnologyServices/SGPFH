class SupplementsController < ApplicationController
  before_action :set_supplement, only: [:show, :edit, :update, :destroy]

  # GET /supplements
  # GET /supplements.json
  def index
    @supplements = Supplement.all
  end

  # GET /supplements/1
  # GET /supplements/1.json
  def show
  end

  # GET /supplements/new
  def new
    @supplement = Supplement.new
  end

  # GET /supplements/1/edit
  def edit
  end

  # POST /supplements
  # POST /supplements.json
  def create
    @supplement = Supplement.new(supplement_params)
    @supplement.award_id = (session[:award].present?) ? session[:award] : nil
    respond_to do |format|
      if @supplement.save
        format.html { redirect_to @supplement, notice: 'Supplement was successfully created.' }
        format.json { render :show, status: :created, location: @supplement }
      else
        format.html { render :new }
        format.json { render json: @supplement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supplements/1
  # PATCH/PUT /supplements/1.json
  def update
    respond_to do |format|
      cTotal = @supplement.total_cost
      if @supplement.update(supplement_params)
        t_diff = @supplement.total_cost - cTotal
        a = @supplement.award
        a.total_requested += t_diff
        a.total_granted = a.total_requested
        a.save
        format.html { redirect_to @supplement.award.patient, notice: 'Supplement was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplement }
      else
        format.html { render :edit }
        format.json { render json: @supplement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplements/1
  # DELETE /supplements/1.json
  def destroy
    p = @supplement.award.patient
    @supplement.destroy
    respond_to do |format|
      format.html { redirect_to patient_url(p), notice: 'Supplement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplement
      @supplement = Supplement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplement_params
      params.require(:supplement).permit(:award_id, :name, :unit_cost, :quantity, :total_cost)
    end
end
