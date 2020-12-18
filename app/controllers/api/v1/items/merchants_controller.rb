class Api::V1::Items::MerchantsController < ApplicationController
  def index
    item = Item.find(params[:id])

    redirect_to api_v1_merchant_path(item.merchant_id)
  end
end
