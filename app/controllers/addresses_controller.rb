class AddressesController < ApplicationController
    def index
      @addresses = Address.all
    end
  
    def new
      @address = Address.new
    end
  
    def create
      @address = Address.new(address_params)
      if @address.save
        redirect_to @address, notice: 'Address was successfully created.'
      else
        render :new
      end
    end
    
    def show
      @address = Address.find(params[:id])
    end

    def edit
        @address = Address.find(params[:id])
    end

    def update
        @address = Address.find(params[:id])
        if @address.update(address_params)
            redirect_to @address, notice: 'Address was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @address = Address.find(params[:id])
        @address.destroy
        redirect_to addresses_url, notice: 'Address was successfully destroyed.'
    end

    private
    def address_params
        params.require(:address).permit(:street, :city, :state, :zip)
    end
  end