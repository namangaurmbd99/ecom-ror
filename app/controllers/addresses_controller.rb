class AddressesController < ApplicationController
  include Pundit
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :authorize_address, except: [:index, :new, :create]

  # GET /addresses
  def index
    @addresses = current_user.addresses
  end

  # GET /addresses/1
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
    authorize @address
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  def create
    @address = current_user.addresses.build(address_params)
    authorize @address

    if @address.save
      redirect_to @address, notice: 'Address was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      redirect_to @address, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
    redirect_to addresses_url, notice: 'Address was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Authorize address actions
    def authorize_address
      authorize @address
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:address, :city, :state, :country)
    end
end
