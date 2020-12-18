class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all.map do |merchant|
      {
        id: merchant.id,
        type: 'merchant',
        attributes: merchant.attributes
      }
    end

    structure = {
      data: merchants
    }

    render json: structure
  end

  def show
    merchant = Merchant.find(params[:id])

    merchant_data = {
      id: merchant.id,
      type: 'merchant',
      attributes: merchant.attributes
    }

    render json: merchant_data
  end

  def create
    merchant = Merchant.create!(permitted_params)

    redirect_to api_v1_merchant_path(merchant.id)
  end

  def update
    merchant = Merchant.find(params[:id])

    merchant.update(permitted_params)

    redirect_to api_v1_merchant_path(merchant.id)
  end

  def destroy
    merchant = Merchant.find(params[:id])

    merchant.destroy

    render nothing: true, status: :no_content
  end

  private

  def permitted_params
    params.require(:merchant).permit(
      :name
    )
  end
end
