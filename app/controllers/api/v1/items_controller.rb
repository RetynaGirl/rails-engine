class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all.map do |item|
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

  def show
    item = Item.find(params[:id])

    item_data = {
      id: item.id,
      type: 'item',
      attributes: item.attributes
    }

    render json: item_data
  end

  def create
    item = Item.create!(permitted_params)

    redirect_to api_v1_item_path(item.id)
  end

  def update
    item = Item.find(params[:id])

    item.update(permitted_params)

    redirect_to api_v1_item_path(item.id)
  end

  def destroy
    item = Item.find(params[:id])

    item.destroy

    render nothing: true, status: :no_content
  end

  private

  def permitted_params
    params.require(:item).permit(
      :name,
      :description,
      :unit_price,
      :merchant_id
    )
  end
end
