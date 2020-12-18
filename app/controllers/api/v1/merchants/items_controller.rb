class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])

    items = merchant.items.map do |item|
      {
        id: item.id,
        type: 'item',
        attributes: item.attributes
      }
    end

    structure = {
      data: items
    }

    render json: structure
  end
end
