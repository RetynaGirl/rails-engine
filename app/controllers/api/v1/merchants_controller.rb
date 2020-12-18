class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all.map do |merchant|
      {
        id: merchant.id.to_s,
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

    render json: structure_single(merchant)
  end

  def create
    merchant = Merchant.create!(permitted_params)

    render json: structure_single(merchant)
  end

  def update
    merchant = Merchant.find(params[:id])

    merchant.update(permitted_params)

    render json: structure_single(merchant)
  end

  def destroy
    merchant = Merchant.find(params[:id])

    merchant.destroy

    render nothing: true, status: :no_content
  end

  private

  def permitted_params
    params.permit(
      :name
    )
  end

  def structure_single(merchant)
    merchant_data = {
      id: merchant.id.to_s,
      type: 'merchant',
      attributes: merchant.attributes
    }

    {
      data: merchant_data
    }
  end
end
