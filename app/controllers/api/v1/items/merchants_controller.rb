class Api::V1::Items::MerchantsController < ApplicationController
  def index
    merchant = Item.find(params[:id]).merchant

    render json: structure_single(merchant)
  end

  private

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
