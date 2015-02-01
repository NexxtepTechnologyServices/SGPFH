class RefPysiciansController < ApplicationController
  before_action :set_ref_pysician, only: [:show, :edit, :update, :destroy]

  # GET /ref_pysicians
  # GET /ref_pysicians.json
  def index
    @ref_pysicians = RefPysician.all
  end

  # GET /ref_pysicians/1
  # GET /ref_pysicians/1.json
  def show
  end

  # GET /ref_pysicians/new
  def new
    @ref_pysician = RefPysician.new
  end

  # GET /ref_pysicians/1/edit
  def edit
  end

  # POST /ref_pysicians
  # POST /ref_pysicians.json
  def create
    @ref_pysician = RefPysician.new(ref_pysician_params)

    respond_to do |format|
      if @ref_pysician.save
        format.html { redirect_to @ref_pysician, notice: 'Ref pysician was successfully created.' }
        format.json { render :show, status: :created, location: @ref_pysician }
      else
        format.html { render :new }
        format.json { render json: @ref_pysician.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ref_pysicians/1
  # PATCH/PUT /ref_pysicians/1.json
  def update
    respond_to do |format|
      if @ref_pysician.update(ref_pysician_params)
        format.html { redirect_to @ref_pysician, notice: 'Ref pysician was successfully updated.' }
        format.json { render :show, status: :ok, location: @ref_pysician }
      else
        format.html { render :edit }
        format.json { render json: @ref_pysician.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ref_pysicians/1
  # DELETE /ref_pysicians/1.json
  def destroy
    @ref_pysician.destroy
    respond_to do |format|
      format.html { redirect_to ref_pysicians_url, notice: 'Ref pysician was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ref_pysician
      @ref_pysician = RefPysician.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ref_pysician_params
      params.require(:ref_pysician).permit(:name)
    end
end
