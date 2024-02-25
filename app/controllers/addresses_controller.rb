class AddressesController < ApplicationController
  include Pundit
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  def index
    @addresses = current_user.addresses
  end

  # GET /addresses/1
  def show
    authorize @address # Check authorization before showing the address
  end

  # GET /addresses/new
  def new
    @address = Address.new
    authorize @address # Check authorization before rendering the new address form
  end

  # GET /addresses/1/edit
  def edit
    authorize @address # Check authorization before rendering the edit address form
  end

  # POST /addresses
  def create
    @address = current_user.addresses.build(address_params)
    authorize @address # Check authorization before creating the address

    if @address.save
      redirect_to @address, notice: 'Address was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /addresses/1
  def update
    authorize @address # Check authorization before updating the address

    if @address.update(address_params)
      redirect_to @address, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /addresses/1
  def destroy
    authorize @address # Check authorization before destroying the address

    @address.destroy
    redirect_to addresses_url, notice: 'Address was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:address, :city, :state, :country)
    end
end
