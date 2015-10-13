class TransController < ApplicationController
  before_action :set_tran, only: [:show, :edit, :update, :destroy]

  # GET /betslips
  # GET /betslips.json
  def index
    @tran = Tran.all


  end

  # GET /betslips/1
  # GET /betslips/1.json
  def show
    @tran = Tran.find(params[:id])
  end

  # GET /betslips/new
  def new
    @tran = Tran.new
  end

  # GET /betslips/1/edit
  def edit
  end

  # POST /betslips
  # POST /betslips.json
  def create
    @account = current_user.accounts.last
    
    @tran = @account.trans.create(tran_params)

    respond_to do |format|
      if @tran.save
        format.html { redirect_to @tran, notice: 'Betslip was successfully created.' }
        format.json { render :show, status: :created, location: @tran }
      else
        format.html { render :new }
        format.json { render json: @betslip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /betslips/1
  # PATCH/PUT /betslips/1.json
  def update
    respond_to do |format|
      if @tran.update(tran_params)
        format.html { redirect_to @betslip, notice: 'Tran was successfully updated.' }
        format.json { render :show, status: :ok, location: @tran }
      else
        format.html { render :edit }
        format.json { render json: @betslip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /betslips/1
  # DELETE /betslips/1.json
  def destroy
    @tran.destroy
    respond_to do |format|
      format.html { redirect_to trans_url, notice: 'Tran was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tran
      @tran = Tran.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tran_params
      params.require(:tran).permit(:stake, :winnings, :total_odds, :status, :user_id)
    end
end
